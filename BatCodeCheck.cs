using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;


namespace RobvanderWoude
{
	public partial class BatCodeCheck
	{
		public static string progver = "0.32.1 beta";

		#region Global variables

		public static int lasterrline = -1;
		public static int lastline = -1;
		public static int linenum = 0;
		public static int lineswitherrors = 0;
		public static int maxvarlen = 32; // Some day, we may have to adjust the accepted variable name length if 32 characters is not enough ([\w\.-]{1,32})
		public static int obsoletecmd = 0;
		public static int parenthesis = 0;
		public static int rc = 1;
		public static int setlocal = 0;
		public static int unterminatedexclamations = 0;
		public static int unterminateddoublequotes = 0;
		public static int unterminatedpercentsigns = 0;
		public static int unterminatedsinglequotes = 0;
		public static bool addtimestamp = false;
		public static bool delayedvarexp = false;
		public static bool delayedvarglobal = false;
		public static bool dispnums = true;
		public static bool errinline = false;
		public static bool htmlopen = false;
		public static bool includelocalvars = false;
		public static bool incomment = false;
		public static bool interactive = false;
		public static bool licensed = true;
		public static bool log2html = false;
		public static bool logging = false;
		public static bool replacehtml = true;
		public static bool replacelog = true;
		public static bool splitoneliners = false;
		public static bool wrap = false;
		public static string allargs;
		public static string allsrc;
		public static string allsrc_nocomments;
		public static string allerrors = String.Empty;
		public static string allbadpr = String.Empty;
		public static string alltips = String.Empty;
		public static string allerrsum = String.Empty;
		public static string dynvarpattern = @"__CD__|CD|CMDCMDLINE|CMDEXTVESION|DATE|ERRORLEVEL|HIGHESTNUMANODENUMBER|RANDOM|TIME";
		public static string html = String.Empty;
		public static string htmlfile = String.Empty;
		public static string intcmdpattern = @"APPEND|ASSOC|BREAK|CALL|CD|CHCP|CHDIR|CLS|COLOR|COPY|DATE|DEL|DIR|DPATH|ECHO|ENDLOCAL|ERASE|EXIT|FOR|FTYPE|GOTO|IF|KEYS|MD|MKDIR|MKLINK|MOVE|PATH|PAUSE|POPD|PROMPT|PUSHD|RD|REM|REN|RENAME|RMDIR|SET|SETLOCAL|SHIFT|START|TIME|TITLE|TRUENAME|TYPE|VER|VERIFY|VOL";
		public static string logfile = String.Empty;
		public static string notx32pattern = @"BREAK|CTTY|FASTOPEN|FASTOPEN\.COM|FASTOPEN\.EXE|KEYS|SHARE|SHARE\.EXE";
		public static string notx64pattern = @"APPEND|APPEND\.COM|APPEND\.EXE|DEBUG|DEBUG\.COM|DEBUG\.EXE";
		public static string source = String.Empty;
		public static string sysvarpattern = @"AllUsersProfile|AppData|CommonProgramFiles|CommonProgramFiles\(x86\)|CommonProgramW6432|ComputerName|ComSpec|HomeDrive|HomePath|LocalAppData|LogonServer|NUMBER_OF_PROCESSORS|OS|Path|PathExt|PROCESSOR_ARCHITECTURE|PROCESSOR_IDENTIFIER|PROCESSOR_LEVEL|PROCESSOR_REVISION|ProgramData|ProgramFiles|ProgramFiles\(x86\)|ProgramW6432|PROMPT|SystemDrive|SystemRoot|TEMP|TMP|UserDomain|UserName|UserProfile|windir";
		public static string timestamp = String.Empty;
		public static string[] path = ( Environment.CurrentDirectory + ";" + Environment.GetEnvironmentVariable( "PATH" ) ).Split( ';' );
		public static string[] pathext = ( ";" + Environment.GetEnvironmentVariable( "PATHEXT" ).ToLower( ) ).Split( ';' );
		public static List<string> labels = new List<string>( );
		public static List<string> upcaselabels = new List<string>( );
		public static List<string> gotoerrors = new List<string>( );
		public static List<string> callerrors = new List<string>( );
		public static List<string> envvars = new List<string>( );
		public static List<string> upcaseenvvars = new List<string>( );
		public static List<string> envvarerrors = new List<string>( );
		public static List<string> localenvvars = new List<string>( );
		public static RegexOptions ignorecase = RegexOptions.IgnoreCase;
		public static StreamWriter htmlstream;
		public static ConsoleColor badprbgcolor = ConsoleColor.Yellow;
		public static ConsoleColor badprfgcolor = ConsoleColor.Red;
		public static ConsoleColor commentfgscolor = ConsoleColor.DarkGreen;
		public static ConsoleColor doublequotedfgcolor = ConsoleColor.Yellow;
		public static ConsoleColor echoedtextfgcolor = ConsoleColor.Cyan;
		public static ConsoleColor linenumbgcolor = ConsoleColor.Gray;
		public static ConsoleColor linenumfgcolor = ConsoleColor.DarkMagenta;
		public static ConsoleColor parenthesisfgcolor = ConsoleColor.Red;
		public static ConsoleColor redirectionfgcolor = ConsoleColor.Red;
		public static ConsoleColor reportbgcolor = Console.BackgroundColor;
		public static ConsoleColor reportfgcolor = ConsoleColor.Red;
		public static ConsoleColor singlequotedfgcolor = ConsoleColor.DarkGray;
		public static ConsoleColor tipsbgcolor = ConsoleColor.Blue;
		public static ConsoleColor tipsfgcolor = ConsoleColor.White;
		public static ConsoleColor variablesfgcolor = ConsoleColor.Green;
		public static ConsoleColor warningbgcolor = ConsoleColor.Red;
		public static ConsoleColor warningfgcolor = ConsoleColor.White;
		public static ConsoleColor windowbgcolor = Console.BackgroundColor;
		public static ConsoleColor windowfgcolor = Console.ForegroundColor;
		// Inline variables
		public static string badprmsg = String.Empty;
		public static string errmsg = String.Empty;
		public static string tipsmsg = String.Empty;
		public static string message = String.Empty;
		public static string part = String.Empty;
		public static string buildword = String.Empty;
		public static string lastword = String.Empty;


		#endregion Global variables


		[STAThread]
		static int Main( string[] args )
		{
			#region Command Line Parsing

			allargs = String.Join( " ", args );

			#region Command Line Arguments

			if ( args.Length == 0 || args.Length > 8 )
			{
				return WriteError( );
			}
			foreach ( string arg in args )
			{
				if ( arg[0] == '/' )
				{
					switch ( arg.ToUpper( ).Substring( 0, Math.Min( 2, arg.Length ) ) )
					{
						case "/?":
							return WriteError( );
						case "/E":
							if ( includelocalvars )
							{
								return WriteError( "Duplicate command line argument /E" );
							}
							includelocalvars = true;
							break;
						case "/H":
							if ( log2html )
							{
								return WriteError( "Duplicate command line argument /H" );
							}
							log2html = true;
							if ( arg.Length > 3 && arg.ToUpper( ).Substring( 2, 1 ) == ":" )
							{
								htmlfile = arg.Substring( 3 );
							}
							break;
						case "/I":
							if ( interactive )
							{
								return WriteError( "Duplicate command line argument /I" );
							}
							interactive = true;
							break;
						case "/L":
							if ( logging )
							{
								return WriteError( "Duplicate command line argument /L" );
							}
							logging = true;
							if ( arg.Length > 3 && arg.ToUpper( ).Substring( 2, 1 ) == ":" )
							{
								logfile = arg.Substring( 3 );
							}
							break;
						case "/S":
							if ( splitoneliners )
							{
								return WriteError( "Duplicate command line argument /S" );
							}
							splitoneliners = true;
							break;
						case "/T":
							if ( addtimestamp )
							{
								return WriteError( "Duplicate command line argument /T" );
							}
							addtimestamp = true;
							break;
						case "/W":
							if ( wrap )
							{
								return WriteError( "Duplicate command line argument /W" );
							}
							wrap = true;
							break;
						default:
							return WriteError( String.Format( "Invalid command line argument \"{0}\"", arg ) );
					}
				}
				else
				{
					if ( String.IsNullOrEmpty( source ) )
					{
						source = arg;
					}
					else
					{
						return WriteError( String.Format( "Invalid command line argument \"{0}\"", arg ) );
					}
				}
			}

			#endregion Command Line Arguments

			// Validate paths if specified
			#region Validate paths

			if ( !interactive )
			{
				if ( String.IsNullOrEmpty( source ) )
				{
					return WriteError( "Please specify a source file" );
				}
				if ( !addtimestamp && source.IndexOfAny( "/?*".ToCharArray( ) ) > -1 )
				{
					return WriteError( );
				}
				if ( !File.Exists( source ) )
				{
					return WriteError( "Source file not found" );
				}
			}
			if ( !String.IsNullOrWhiteSpace( source ) )
			{
				source = Path.GetFullPath( source );
			}
			if ( !String.IsNullOrEmpty( logfile ) )
			{
				if ( !Directory.Exists( Directory.GetParent( logfile ).FullName ) )
				{
					return WriteError( "Invalid path to log file" );
				}
				logfile = Path.GetFullPath( logfile );
			}
			if ( !String.IsNullOrEmpty( htmlfile ) )
			{
				if ( !Directory.Exists( Directory.GetParent( htmlfile ).FullName ) )
				{
					return WriteError( "Invalid path to HTML file" );
				}
				htmlfile = Path.GetFullPath( htmlfile );
			}

			#endregion Validate paths

			// Local environment variable %BatCodeCheck% can be used to set defaults, but it is overruled by command line arguments
			#region BatCodeCheck Environment Variable

			try
			{
				string envargs = Environment.GetEnvironmentVariable( "BatCodeCheck" ).ToUpper( );
				if ( new Regex( @"^\s*(/[EHILSTW]\s*)+$" ).IsMatch( envargs ) )
				{
					foreach ( Match match in new Regex( "/[EHILSTW]" ).Matches( envargs ) )
					{
						switch ( match.ToString( ) )
						{
							case "/E":
								if ( !includelocalvars )
								{
									includelocalvars = true;
									allargs += " /E";
								}
								break;
							case "/H":
								if ( !log2html )
								{
									log2html = true;
									allargs += " /H";
								}
								break;
							case "/I":
								if ( !interactive )
								{
									interactive = true;
									allargs += " /I";
								}
								break;
							case "/L":
								if ( !logging )
								{
									logging = true;
									allargs += " /L";
								}
								break;
							case "/S":
								if ( !splitoneliners )
								{
									splitoneliners = true;
									allargs += " /S";
								}
								break;
							case "/T":
								if ( !addtimestamp )
								{
									addtimestamp = true;
									allargs += " /T";
								}
								break;
							case "/W":
								if ( !wrap )
								{
									wrap = true;
									allargs += " /W";
								}
								break;
						}
					}
				}
			}
			catch ( Exception )
			{
				// Environment variable BatCodeCheck not found
			}

			#endregion BatCodeCheck Environment Variable

			// Defaults
			#region Command Line Defaults

			if ( !includelocalvars )
			{
				pathext = ".com;.exe;.bat;.cmd".Split( ';' );
			}
			if ( addtimestamp )
			{
				AddTimeStamp( );
			}
			if ( log2html && String.IsNullOrWhiteSpace( htmlfile ) )
			{
				htmlfile = Path.Combine( Path.GetDirectoryName( source ), Path.GetFileNameWithoutExtension( source ) + timestamp + ".html" );
			}
			if ( logging && String.IsNullOrWhiteSpace( logfile ) )
			{
				logfile = Path.Combine( Path.GetDirectoryName( source ), Path.GetFileNameWithoutExtension( source ) + timestamp + ".log" );
			}

			#endregion Command Line Defaults

			// Interactive (licensed version only)
			#region Interactive

			if ( licensed && interactive )
			{
				try
				{
					if ( !ShowSettings( ) )
					{
						Console.Error.WriteLine( "Aborted by user request" );
						return 1;
					}
				}
				catch ( Exception )
				{
					return WriteError( "Interactive use of BatCodeCheck (/I switch) requires a licensed version" );
				}
			}

			#endregion Interactive

			#endregion Command Line Parsing

			try
			{
				if ( File.Exists( source ) )
				{
					ReadSource( source );
					CollectEnvironmentVariables( );
					CollectLabels( );
					OpenHTML( );

					// Now parse the source line by line
					rc = 0;
					foreach ( string line in allsrc.Split( new string[] { "\r\n", "\n", "\r" }, StringSplitOptions.None ) )
					{
						linenum += 1;

						// If /S switch was used, split the line on parenthesis and ampersands, except parentheses surrounding the list in FOR loops, and except comments
						if ( splitoneliners && !new Regex( @"^\s*(::|REM)(\b|\s|$)", ignorecase ).IsMatch( line ) && line.IndexOfAny( "(&|)".ToCharArray( ) ) > -1 )
						{
							bool inelse = false;
							bool inforloop = false;
							string tmpline = String.Empty;

							string pattern = @"(?<!\^)\((?!['\n\r])";
							Regex regex = new Regex( pattern );
							if ( regex.IsMatch( line ) )
							{
								MatchCollection matches = regex.Matches( line );
								tmpline = line.Substring( 0, matches[0].Index );
								if ( new Regex( @"\s%%[A-Z!]\s+IN\s+$", ignorecase ).IsMatch( tmpline ) )
								{
									inforloop = true;
								}
								else if ( new Regex( @"\)\s+ELSE\s+\(", ignorecase ).IsMatch( tmpline ) )
								{
									inelse = true;
								}

							}
							if ( inforloop || inelse )
							{
								tmpline = regex.Replace( line, "(\n\t", 100, line.IndexOf( ')' ) + 1 );
							}
							else
							{
								tmpline = regex.Replace( line, "(\n\t" );
							}

							pattern = @"(?<!['\^\n\r])\)";
							regex = new Regex( pattern );
							if ( inforloop || inelse )
							{
								tmpline = regex.Replace( tmpline, "\n)", 100, line.IndexOf( ')' ) + 1 );
							}
							else
							{
								tmpline = regex.Replace( tmpline, "\n)" );
							}

							pattern = @"(?<!\^|2>|1>)&(?>!1|2)";
							regex = new Regex( pattern );
							tmpline = regex.Replace( tmpline, "\n\t" );

							foreach ( string part in tmpline.Split( new string[] { "\n" }, StringSplitOptions.None ) )
							{
								if ( !String.IsNullOrWhiteSpace( part ) )
								{
									ParseLine( part );
								}
							}
						}
						else
						{
							ParseLine( line );
						}
					}
					DisplayMessagesSummary( );
					CloseHTML( );
					RestoreConsoleColors( );
					return rc;
				}
				else
				{
					return WriteError( String.Format( "File \"{0}\" not found", source ) );
				}
			}
			catch ( Exception e )
			{
				return WriteError( e.Message );
			}
		}


		#region Subroutines

		public static void AddTimeStamp( )
		{
			if ( String.IsNullOrWhiteSpace( timestamp ) )
			{
				timestamp = DateTime.Now.ToString( ".yyyyMMddHHmmss" );
			}
		}

		public static void CheckBadPractices( string line )
		{
			string pattern;
			Regex regex;

			// SET dynamic variables
			#region SET dynamic variables

			pattern = String.Format( @"\bSET\s+({0})=", dynvarpattern );
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string dynvar = matches[0].Groups[1].Value;
				message = String.Format( "Setting dynamic variable \"{0}\" to a static value may cause problems later on in the batch file; consider using an alternative variable name instead", dynvar.ToUpper( ) );
				allbadpr += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				badprmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion SET dynamic variables

			// SET system variables
			#region SET system variables

			pattern = String.Format( @"\bSET\s+({0})=", sysvarpattern );
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string dynvar = matches[0].Groups[1].Value;
				message = String.Format( "Setting system variable \"{0}\" may cause problems later on in the batch file; consider using an alternative variable name instead", dynvar.ToUpper( ) );
				allbadpr += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				badprmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion SET system variables

			// Quoted paths
			// Disabled for now, as it is extremely hard, if possible at all, to extract a path from a command line without a true interpreter
			#region Quoted paths
			/*
			pattern = @"[^""=]((?:[A-Z]:|\\\\\w+\\\w+)(?:\\[^\\]+)*\\[^\s\\]+\s+[^\\]+(?:\\[^\\]+)*(?:\\|\b|$))";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string path = matches[0].Groups[1].ToString( );
				message = String.Format( "Whitespace found in unquoted path: \"{0}\"", path );
				allbadpr += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				badprmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			pattern = @"[^""]((?:[A-Z]:|\\\\\w+\\\w+)(?:\\[^\\]+)*\\[^\\]*(\(|\))[^\\]*(?:\\[^\\]+)*\\?(?:\b|$))";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string path = matches[0].Groups[1].ToString( );
				string spec = matches[0].Groups[2].ToString( );
				message = String.Format( "Parenthesis found in unquoted path: \"{1}\"; use doublequotes, especially inside code blocks", spec, path );
				allbadpr += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				badprmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			pattern = @"[^""=]((?:[A-Z]:|\\\\\w+\\\w+)(?:\\[^\\]+)*\\[^\\]*(&|'|,|\^)[^\\]*(?:\\[^\\]+)*\\?(?:\b|$))";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string path = matches[0].Groups[1].ToString( );
				string spec = matches[0].Groups[2].ToString( );
				message = String.Format( "Special character \"{0}\" found in unquoted path: \"{1}\"; use doublequotes", spec, path );
				allbadpr += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				badprmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}
			*/
			#endregion Quoted paths
		}

		public static void CheckBestPractices( string line )
		{
			string pattern;
			Regex regex;

			// Doublequotes in SET statements
			#region Doublequoted SET

			pattern = @"(?:^|\b|\()(SET\s+""([\w_\.-]+)=([^""&\n\r]+)"")";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				foreach ( Match match in regex.Matches( line ) )
				{
					string wrong = match.Groups[1].ToString( );
					string correct = String.Format( "SET {0}={1}", match.Groups[2].ToString( ), match.Groups[3].ToString( ) );
					message = String.Format( "Doublequoted SET statements are not recommended, except with /A (or /P) switch; use {0} instead of {1}", correct, wrong );
					alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					tipsmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
			}

			#endregion Doublequoted SET

			// Whitespace around equal signs in IF statements
			#region Whitespace around equal signs

			pattern = @"(^|\b)IF\s+(/I\s+)?(?:\w+|\""[^""]+\"")\s*==?\s*(?:\w+|\""[^""]+\"")\s*[\(\w]";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				pattern = @"(?:^|\b)(IF\s+(/I\s+)?(\w+|\""[^""]+\"")(?:\s+==?\s*|\s*==?\s+)(\w+|\""[^""]+\""))\s*[\(\w]";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					string wrong = matches[0].Groups[1].ToString( );
					string correct = String.Format( "IF {0}{1}=={2}", ( String.IsNullOrWhiteSpace( matches[0].Groups[2].ToString( ) ) ? String.Empty : "/I " ), matches[0].Groups[3].ToString( ), matches[0].Groups[4].ToString( ) );
					message = String.Format( "Whitespace around the double equal sign in an IF statement is not recommended, use {0} instead of {1}", correct, wrong );
					alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					tipsmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
			}

			#endregion Whitespace around equal signs

			// Devices with appended colons
			#region Devices with appended colons

			pattern = @"(?:>|\b)(AUX|CLOCK\$|COM[1-8]|CON|LPT[1-8]|NUL|PRN):(?:\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string device = matches[0].Groups[1].ToString( ).ToUpper( );
				message = String.Format( "Redundant colon appended to device name \"{0}\"", device );
				alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				tipsmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion Devices with appended colons

			// Obsolete commands BREAK, CTTY, KEYS, and 16-bit commands
			#region Obsolete commands

			pattern = String.Format( @"(?:^|&|\|\()\s*({0})\b", notx32pattern );
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				foreach ( Match match in matches )
				{
					string cmd = match.Groups[1].ToString( ).ToUpper( );
					message = String.Format( "Obsolete command \"{0}\" is accepted only for MS-DOS backwards compatibility", cmd );
					alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					tipsmsg += String.Format( "\n{0}.", message );
					obsoletecmd += 1;
				}
				errinline = true;
			}

			pattern = String.Format( @"(?:^|&|\|\()\s*({0})\b", notx64pattern );
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				foreach ( Match match in matches )
				{
					string cmd = match.Groups[1].ToString( ).ToUpper( );
					if ( System.Environment.Is64BitOperatingSystem )
					{
						message = String.Format( "16-bit command \"{0}\" is not available in 64-bit Windows", cmd );
						allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						errmsg += String.Format( "\n{0}.", message );
					}
					else
					{
						message = String.Format( "16-bit command \"{0}\" will not be available in 64-bit Windows", cmd );
						alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						tipsmsg += String.Format( "\n{0}.", message );
					}
					obsoletecmd += 1;
				}
				errinline = true;
			}

			#endregion Obsolete commands

			// @ all over the place
			#region Hiding command echo

			if ( linenum > 1 )
			{
				pattern = @"^\s*@(?>!ECHO\s*(ON|OFF)\s)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					message = "Using multiple @s to hide command echoing is NOT recommended, as it makes debugging batch files harder. @ECHO OFF at the start of the batch file suffices to hide ALL command echoing.";
					alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					tipsmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
			}
			#endregion Hiding command echo
		}

		public static void CheckCommonMistakes( string line )
		{
			string pattern;
			Regex regex;

			// IF [NOT] EXISTS or IF [NOT] EXIT or IF [NOT] EXITS instead of IF EXIST
			#region IF EXIST

			pattern = @"\bIF(\s+NOT)?\s+EXI(STS|T|TS)\s";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				//message = "Found \"IF EXISTS ...\" (note the incorrect trailing \"S\"); use \"IF EXIST ...\" (without trailing \"S\") instead";
				MatchCollection matches = regex.Matches( line );
				string matchall = matches[0].ToString( ).ToUpper( );
				string matchnot = matches[0].Groups[1].ToString( ).ToUpper( );
				string matchend = matches[0].Groups[2].ToString( ).ToUpper( );
				switch ( matchend )
				{
					case "STS":
						message = String.Format( "Found \"{0} ...\" (note the incorrect trailing \"S\"); use \"IF{1} EXIST ...\" (without trailing \"S\") instead", matchall, matchnot );
						break;
					case "T":
						message = String.Format( "Found \"{0} ...\" (note the missing \"S\"); use \"IF{1} EXIST ...\" (with \"S\") instead", matchall, matchnot );
						break;
					case "TS":
						message = String.Format( "Found \"{0} ...\" (note the swapped \"S\" and \"T\"); use \"IF{1} EXIST ...\" (\"S\" first, followed by \"T\") instead", matchall, matchnot );
						break;
				}
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion IF EXIST

			// Common typos for %AllUsersProfile% variable
			#region AllUsersProfile

			pattern = @"(%|!)(A+L+USERPROFILES?)(\1)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				foreach ( Match match in matches )
				{
					string wrong = match.Groups[2].ToString( ).ToUpper( );
					string varchr = match.Groups[1].ToString( );
					message = String.Format( "Possible typo: the system variable name is spelled \"{0}ALLUSERSPROFILE{0}\", not \"{0}{1}{0}\"", varchr, wrong );
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
			}

			#endregion AllUsersProfile

			// IF [NOT] ERRORLEVEL 0
			#region IF ERRORLEVEL 0

			pattern = @"(^|\b|\()IF\s+ERRORLEVEL\s+0\s";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				message = "IF ERRORLEVEL 0 tests if the errorlevel is greater than or equal to 0, so it ALWAYS returns true; use either IF NOT ERRORLEVEL 1 or IF %ErrorLevel% EQU 0 instead";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
				rc = linenum;
			}

			pattern = @"(^|\b|\()IF\s+NOT\s+ERRORLEVEL\s+0\s";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				message = "IF NOT ERRORLEVEL 0 tests if the errorlevel is less than 0, so it always ALWAYS returns false; use either IF ERRORLEVEL 1 or IF %ErrorLevel% NEQ 0 instead";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
				rc = linenum;
			}

			#endregion IF ERRORLEVEL 0

			// :: inside code blocks
			#region Double colons in code blocks

			// check if :: is used inside a code block, but skip REM or ECHO followed by ::
			bool codeblock = ( parenthesis > 0 );
			bool dblcolcmnt = ( line.IndexOf( "::" ) > line.IndexOfAny( "(&|".ToCharArray( ) ) );
			bool echoedcmnt = new Regex( @"^([^:]*|([^:]*:[^:]+)*)ECHO\b[^\n\r&\|\>]*::", ignorecase ).IsMatch( line ); // Skip if ECHO is found before :: and no redirection in between
			bool remcomment = new Regex( @"^([^:]*|([^:]*:[^:]+)*)REM\b[^\n\r&]*::", ignorecase ).IsMatch( line ); // Skip if REM is found before :: and no ampersand in between
			if ( dblcolcmnt && codeblock && !remcomment && !echoedcmnt )
			{
				message = "Found \"::\" inside a code block (i.e. in parenthesis); use \"REM\" instead";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
				rc = linenum;
			}

			#endregion Double colons in code blocks

			// CALLs to undefined subroutines
			#region CALLs

			if ( new Regex( @"(?:^|\b)CALL\s+:", ignorecase ).IsMatch( line ) )
			{
				MatchCollection matches = new Regex( @"(?:^|\b)CALL\s+:([\w\.\[\]/+\-\(\)\{\}]{1,127})", ignorecase ).Matches( line );
				foreach ( Match match in matches )
				{
					string label = match.Groups[1].ToString( );
					if ( !labels.Contains( label ) )
					{
						callerrors.Add( label );
						message = String.Format( "A CALL is made to a subroutine named \"{0}\" but the subroutine was not found; note that subroutine labels are case sensitive", label );
						allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						errmsg += String.Format( "\n{0}.", message );
						errinline = true;
					}
				}
			}

			#endregion CALLs

			// GOTOs to undefined labels
			#region GOTOs

			if ( new Regex( @"(?:^|\b)GOTO\s", ignorecase ).IsMatch( line ) )
			{
				MatchCollection matches = new Regex( @"(?:^|\b)GOTO\s+:?([\w\.\[\]/+\-]{1,127})[\)&|\s]*", ignorecase ).Matches( line );
				foreach ( Match match in matches )
				{
					string label = match.Groups[1].ToString( );
					if ( label.ToUpper( ) != "EOF" && !upcaselabels.Contains( label.ToUpper( ) ) )
					{
						gotoerrors.Add( label );
						message = String.Format( "A jump (GOTO) to a label named \"{0}\" was detected, but the label was not found", label );
						allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						errmsg += String.Format( "\n{0}.", message );
						errinline = true;
					}
				}
			}

			#endregion GOTOs

			// Redirected Standard Error typos
			#region Redirected Standard Error

			pattern = @"\s(2(?:>>|<+|\s+)&\s*1)(?:\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string redirect = matches[0].Groups[1].ToString( ).ToUpper( );
				message = String.Format( "Incorrect redirection of Standard Error to Standard Output: \"{0}\"", redirect );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			pattern = @"\s(1(?:>>|<+|\s+)&\s*2)(?:\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				MatchCollection matches = regex.Matches( line );
				string redirect = matches[0].Groups[1].ToString( ).ToUpper( );
				message = String.Format( "Incorrect redirection of Standard Output to Standard Error: \"{0}\"", redirect );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion Redirected Standard Error

			// Unescaped redirection in FOR /F loops
			#region Unescaped redirection in FOR /F loops

			pattern = @"FOR\s+/F\s+(""((delims|eol|skip|tokens)=[^ ""]*\s*|usebackq\s*)*"")?\s*%%[A-Z?]\s+IN\s+\('[^\^']*[\&\<\>\|]";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				message = "Unescaped redirection symbol(s) in a FOR /F loop";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion Unescaped redirection in FOR /F loops

			// Unescaped ECHOed parenthesis inside code block
			#region Unescaped ECHOed parenthesis inside code block

			if ( parenthesis > 0 ) // if we're inside a code block...
			{
				pattern = @"(^|\b)ECHO(?=\.|\s)[^&\|\n\r\(\)^]*[^^][\(\)]";
			}
			else
			{
				pattern = @"\(\s*ECHO(?=\.|\s)[^&\|\n\r\(\)^]*[^^][\(\)]";
			}
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				message = "Unescaped ECHOed parenthesis inside a code block";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion Unescaped ECHOed parenthesis inside code block

			// Delayed variables with delayed variable expansion disabled vv.
			#region Delayed variables without delayed expansion

			if ( delayedvarexp )
			{
				pattern = @"%\w{1,16}%";
				regex = new Regex( pattern );
				if ( regex.IsMatch( line ) )
				{
					string envvar = regex.Match( line ).Value.ToUpper( );
					string varname = envvar.Substring( 1, envvar.Length - 2 );
					// Skip warning if we are dealing with a (dynamic) system variable
					pattern = String.Format( @"^({0}|{1})$", dynvarpattern, sysvarpattern );
					if ( !new Regex( pattern, ignorecase ).IsMatch( varname ) )
					{
						message = String.Format( "Variable \"{0}\" found with delayed variable expansion enabled; shouldn't that be \"!{1}!\" instead?", envvar, varname );
						// Skip warning if line is a comment
						if ( !new Regex( @"(^|&)\s*(REM($|\s)|::)", ignorecase ).IsMatch( line ) )
						{
							allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
							errmsg += String.Format( "\n{0}.", message );
							errinline = true;
						}
					}
				}
			}
			else
			{
				pattern = @"!\w{1,16}!";
				regex = new Regex( pattern );
				if ( regex.IsMatch( line ) )
				{
					// Skip warning if line is a comment
					if ( !new Regex( @"^\s*(REM($|\s)|::)", ignorecase ).IsMatch( line ) )
					{
						if ( delayedvarglobal )
						{
							message = String.Format( "\"{0}\" looks like a delayed variable, check if delayed variable expansion is enabled", regex.Match( line ).Value.ToUpper( ) );
							allbadpr += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
							badprmsg += String.Format( "\n{0}.", message );
						}
						else
						{
							message = String.Format( "\"{0}\" looks like a delayed variable, but delayed variable expansion is not enabled", regex.Match( line ).Value.ToUpper( ) );
							allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
							errmsg += String.Format( "\n{0}.", message );
						}
						errinline = true;
					}
				}
			}

			#endregion Delayed variables without delayed expansion

			// Excess number of delimiters in FOR /F loop
			#region Too many delimiters

			pattern = @"(?<!\w)FOR\s+/F\s+\""(?:[^""]+\s)?delims=([^\s\)\""]{5,})(?:\s[^""]+)?\""";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				string delims = regex.Match( line ).Groups[1].ToString( );
				List<char> nodups = new List<char>( );
				foreach ( char del in delims )
				{
					if ( !nodups.Contains( del ) )
					{
						nodups.Add( del );
					}
				}
				if ( nodups.Count == delims.Length )
				{
					message = String.Format( "Found {0} delimiters in a FOR /F loop: \"{1}\". Are you trying to split a string on a WORD? The value of \"delims\" is a CHARACTER array, each individual character is a delimiter", delims.Length, delims, delims.Length - nodups.Count );
					alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					tipsmsg += String.Format( "\n{0}.", message );
				}
				else
				{
					message = String.Format( "Found {0} delimiters in a FOR /F loop: \"{1}\" (including {2} duplicates). Are you trying to split a string on a WORD? The value of \"delims\" is a CHARACTER array, each individual character is a delimiter", delims.Length, delims, delims.Length - nodups.Count );
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
				}
				errinline = true;
			}
			else
			{
				pattern = @"(?<!\w)FOR\s+/F\s+\""(?:[^""]+\s)?delims=([^\s\)\""]+)(?:\s[^""]+)?\""";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string delims = regex.Match( line ).Groups[1].ToString( );
					List<char> nodups = new List<char>( );
					foreach ( char del in delims )
					{
						if ( !nodups.Contains( del ) )
						{
							nodups.Add( del );
						}
					}
					if ( delims.Length > nodups.Count )
					{
						message = String.Format( "Found {0} duplicate delimiters (delims={1}) in a FOR /F loop", delims.Length - nodups.Count, delims );
						allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						errmsg += String.Format( "\n{0}.", message );
						errinline = true;
					}
				}
			}

			#endregion Too many delimiters

			// Wildcards in IF comparison
			#region Wildcards in IF comparison

			pattern = @"\bIF\s+(?:/I\s+)?(?:NOT\s+)?\""%\w{1,16}%\""\s*==\s*\""[^""\*\?]*[\*\?]";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				message = "Wildcard character(s) found in IF comparison; IF \"%var%\"==\"literal_string\" does not accept wildcards; though asterisks and exclamation marks CAN be valid literals, make sure you did not try to apply them as wildcards";
				alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				tipsmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion Wildcards in IF comparison

			// Undefined variables
			#region Undefined variables

			// Skip this test if variable is inside comment
			pattern = @"^\s*(::|REM\s)";
			regex = new Regex( pattern, ignorecase );
			if ( !regex.IsMatch( line ) )
			{
				// This regex pattern catches "straight" variables as well as "nested" ones
				pattern = @"((?<!%)%{1,2}|(?:\^!)?!)([\w\.-]{1," + maxvarlen + @"})(\1|:)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					foreach ( Match match in matches )
					{
						string envvar = match.Groups[2].ToString( );
						if ( !upcaseenvvars.Contains( envvar.ToUpper( ) ) )
						{
							if ( !envvarerrors.Contains( envvar.ToUpper( ) ) )
							{
								envvarerrors.Add( envvar.ToUpper( ) );
							}
							if ( includelocalvars || !localenvvars.Contains( envvar.ToUpper( ) ) )
							{
								message = String.Format( "Undefined variable \"{0}\"", envvar );
								allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
								errmsg += String.Format( "\n{0}.", message );
							}
							else
							{
								message = String.Format( "Variable \"{0}\" is never set in the batch file; however, the variable IS set in this computer's local environment. Use BatCodeCheck's \"/L\" switch to include the local environment variables", envvar );
								allbadpr += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
								badprmsg += String.Format( "\n{0}.", message );
							}
							errinline = true;
						}
					}
				}
			}

			#endregion Undefined variables

			// count SETLOCAL and ENDLOCAL pairs
			#region SETLOCAL ENDLOCAL pairs

			pattern = @"^\s*SETLOCAL\b";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				setlocal += 1;
			}
			if ( setlocal > 1 )
			{
				message = "Found a nested SETLOCAL";
				if ( allerrors.IndexOf( message ) > -1 )
				{
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
				}
				errinline = true;
			}

			pattern = @"^\s*ENDLOCAL\b";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				setlocal -= 1;
			}
			if ( setlocal < 0 )
			{
				message = "Number of ENDLOCALs exceeds number of SETLOCALs";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion SETLOCAL ENDLOCAL pairs

			// Whitespace and equal signs in IF statements
			#region Whitespace and equal signs in IF statements

			pattern = @"(^|\b)IF\s+(/I\s+)?(?:\w+|\""[^""]+\"")\s*==?\s*(?:\w+|\""[^""]+\"")\s*[\(\w]";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				// Single equal sign
				pattern = @"(^|\b)IF\s+(/I\s+)?(?:\w+|\""[^""]+\"")\s*=\s*(?:\w+|\""[^""]+\"")\s*[\(\w]";
				regex = new Regex( pattern, RegexOptions.IgnoreCase );
				if ( regex.IsMatch( line ) )
				{
					message = "Single equal sign in IF statement, where a double equal sign is required";
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
				// Whitespace before code block
				pattern = @"(?:^|\b)(IF\s+(/I\s+)?(\w+|\""[^""]+\"")\s*==?\s*(\w+|\""[^""]+\"")\()";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					MatchCollection matches = regex.Matches( line );
					string wrong = matches[0].ToString( );
					string correct = String.Format( "IF {0}{1}=={2} (", ( String.IsNullOrWhiteSpace( matches[0].Groups[2].ToString( ) ) ? String.Empty : "/I " ), matches[0].Groups[3].ToString( ), matches[0].Groups[4].ToString( ) );
					message = String.Format( "Insert whitespace after the IF comparison, before the opening parenthesis of the code block: {0}...) instead of {1}...)", correct, wrong );
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
			}

			#endregion Whitespace and equal signs in IF statements
		}

		public static void CheckCommandLineArguments( string line )
		{
			string pattern;
			Regex regex;

			// Invalid arguments for ASSOC command
			#region ASSOC command line

			pattern = @"(^|\b|\()ASSOC(\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				pattern = @"(?:^|\b|\()ASSOC(\s+\.\w+(?:=[\w \.\-]{3,})?)?\s*$";
				regex = new Regex( pattern, ignorecase );
				if ( !regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b|\()ASSOC([^\n\r&|]+)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						string cla = regex.Match( line ).Groups[1].ToString( ).Trim( );
						if ( !String.IsNullOrWhiteSpace( cla ) && cla[0] != '/' ) // No need to display a message for switches, the check for switches will handle that
						{
							message = String.Format( "Invalid command line argument(s) \"{0}\" for ASSOC command", cla );
							allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
							errmsg += String.Format( "\n{0}.", message );
							errinline = true;
						}
					}
				}
			}

			#endregion ASSOC command line

			// Invalid arguments for BREAK command
			#region BREAK command line

			pattern = @"(^|\b|\()BREAK(\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				pattern = @"(?:^|\b|\()BREAK(\s+(ON|OFF))\s*$";
				regex = new Regex( pattern, ignorecase );
				if ( !regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b|\()BREAK([^\n\r&|]+)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						string cla = regex.Match( line ).Groups[1].ToString( ).Trim( );
						if ( !String.IsNullOrWhiteSpace( cla ) && cla[0] != '/' ) // No need to display a message for switches, the check for switches will handle that
						{
							message = String.Format( "Invalid command line argument \"{0}\" for BREAK command, the only arguments accepted are ON and OFF", cla );
							allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
							errmsg += String.Format( "\n{0}.", message );
							errinline = true;
						}
					}
				}
				message = "The BREAK command is available for backward compatibility only, it does not DO anything in Windows";
				alltips += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				tipsmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion BREAK command line

			// Invalid arguments for CALL command
			#region CALL command line

			pattern = @"(?:^|\b|\()CALL\s+([^\n\r\s]+)(\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				bool callerr = false;
				string cla = regex.Match( line ).Groups[1].ToString( );
				if ( String.IsNullOrWhiteSpace( cla ) )
				{
					callerr = true;
				}
				else
				{
					if ( cla[0] != ':' ) // CALLs to subroutine labels will be handled later
					{
						pattern = String.Format( @"^({0})$", intcmdpattern );
						regex = new Regex( pattern, ignorecase );
						if ( !regex.IsMatch( cla ) )
						{
							if ( String.IsNullOrWhiteSpace( Which( cla ) ) )
							{
								callerr = true;
							}
						}
					}
				}
				if ( callerr )
				{
					message = String.Format( "Invalid command line argument \"{0}\" for CALL command: no matching internal command, nor external command was found", cla );
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
			}

			#endregion CALL command line

			// Invalid switch for CD command
			#region CD switches

			pattern = @"(?:^|\b|\()(CD|CHDIR)\s+(/[^D][^\n\r\s/]*)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				string cmd = regex.Match( line ).Groups[1].ToString( );
				string cls = regex.Match( line ).Groups[2].ToString( );
				message = String.Format( "Invalid command line switch \"{0}\" for {1} command, the only accepted switch is /D", cls, cmd );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion CD switches

			// Invalid argument for DATE command
			#region DATE arguments

			pattern = @"(^|\b|\()(?<![%!])DATE(?>![%!:])(\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				pattern = @"(?:^|\b|\()DATE\s+(/[^T][^\^\n\r\s&|\)']*|/T[^\^\n\r\s&|\)']+)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cls = regex.Match( line ).Groups[1].ToString( );
					message = String.Format( "Invalid command line switch \"{0}\" for DATE command, the only valid switch is /T", cls );
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
				else
				{
					pattern = @"(?:^|\b|\()DATE\s+(/T|(%|!)[\w_-]{1,16}\2|[\d/-]{10})";
					regex = new Regex( pattern, ignorecase );
					if ( !regex.IsMatch( line ) )
					{
						string cls = regex.Match( line ).Groups[1].ToString( );
						message = String.Format( "Invalid command line argument \"{0}\" for DATE command, this should be a date", cls );
						allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						errmsg += String.Format( "\n{0}.", message );
						errinline = true;
					}
				}
			}

			#endregion DATE arguments

			// Invalid switch for EXIT command
			#region EXIT switches

			pattern = @"(?:^|\b|\()EXIT\s+(/[^B][^\n\r\s/]*)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				string cls = regex.Match( line ).Groups[1].ToString( );
				message = String.Format( "Invalid command line switch \"{0}\" for EXIT command, the only accepted switch is /B", cls );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion EXIT switches

			// Invalid switch for FOR command
			#region FOR switches

			pattern = @"(?:^|\b|\()FOR\s+(/[^DFLR][^\n\r\s=/]*)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				message = String.Format( "Invalid command line switch \"{0}\" for FOR command, accepted switches are /D, /F, /L and /R", regex.Match( line ).Groups[1].ToString( ) );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion FOR switches

			// Invalid arguments for FTYPE command
			#region FTYPE command line

			pattern = @"(^|\b|\()FTYPE(\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				pattern = @"(?:^|\b|\()FTYPE(\s+[^\.\n\r&|][\w \.\-]{2,}(=[\w: \.\\\-\(\)]+)?)?\s*$";
				regex = new Regex( pattern, ignorecase );
				if ( !regex.IsMatch( line ) )
				{
					pattern = @"(?:^|\b|\()FTYPE\s+([^\n\r&|]+)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						string cla = regex.Match( line ).Groups[1].ToString( ).Trim( );
						if ( !String.IsNullOrWhiteSpace( cla ) && cla[0] != '/' ) // No need to display a message for switches, the check for switches will handle that
						{
							message = String.Format( "Invalid command line argument(s) \"{0}\" for FTYPE command", cla );
							allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
							errmsg += String.Format( "\n{0}.", message );
							errinline = true;
						}
					}
				}
			}

			#endregion FTYPE command line

			// Invalid switch for IF command
			#region IF switches

			pattern = @"(?:^|\b|\()IF\s+(/[^I][^\n\r\s/]*)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				string cls = regex.Match( line ).Groups[1].ToString( );
				message = String.Format( "Invalid command line switch \"{0}\" for IF command, the only accepted switch is /I", cls );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion IF switches

			// Invalid switch for SET command
			#region SET switches

			pattern = @"(?:^|\b|\()SET\s+(/[^AP][^\n\r\s=/]*)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				message = String.Format( "Invalid command line switch \"{0}\" for SET command, accepted switches are /A and /P", regex.Match( line ).Groups[1].ToString( ) );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion SET switches

			// Invalid switch for SHIFT command
			#region SHIFT switches

			pattern = @"(?:^|\b|\()SHIFT\s+(/[^0-8][^\n\r\s/]*)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				string cls = regex.Match( line ).Groups[1].ToString( );
				message = String.Format( "Invalid command line switch \"{0}\" for SHIFT command, the only accepted switch is a forward slash followed by a number from 0 to 8", cls );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion SHIFT switches

			// Invalid argument for TIME command
			#region TIME arguments

			pattern = @"(^|\b|\()(?<![%!])TIME(?>![%!:])(\b|$)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				pattern = @"(?:^|\b|\()TIME\s+(/[^T][^\^\n\r\s&|\)']*|/T[^\^\n\r\s&|\)']+)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cls = regex.Match( line ).Groups[1].ToString( );
					message = String.Format( "Invalid command line switch \"{0}\" for TIME command, the only valid switch is /T", cls );
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
				else
				{
					pattern = @"(?:^|\b|\()TIME\s+(/T|(%|!)[\w_-]{1,16}\2|[\d:\.,AMP\s]{4,11})";
					regex = new Regex( pattern, ignorecase );
					if ( !regex.IsMatch( line ) )
					{
						string cls = regex.Match( line ).Groups[1].ToString( );
						message = String.Format( "Invalid command line argument \"{0}\" for TIME command, this should be a time value", cls );
						allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						errmsg += String.Format( "\n{0}.", message );
						errinline = true;
					}
				}
			}

			#endregion TIME arguments

			// Switches not allowed for ASSOC, CALL, COLOR, FTYPE, GOTO, MD, MKDIR, PUSHD, SETLOCAL
			#region Switches not allowed

			pattern = @"(?:^|\b|\()(ASSOC|CALL|COLOR|FTYPE|GOTO|MD|MKDIR|PUSHD|SETLOCAL)\s+(/[^\n\r\s=/]*)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				string cmd = regex.Match( line ).Groups[1].ToString( ).ToUpper( );
				string cls = regex.Match( line ).Groups[2].ToString( );
				message = String.Format( "Switch \"{1}\" for {0} command is not valid, as {0} does not accept switches at all", cmd, cls );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion Switches not allowed

			// Arguments not required for CLS, ENDLOCAL, PAUSE, POPD, VER
			#region Arguments not required

			pattern = @"(?:^|\b|\()(CLS|ENDLOCAL|PAUSE|POPD|VER)\s+([^\n\r&|>]+)";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				string cmd = regex.Match( line ).Groups[1].ToString( ).ToUpper( );
				string cla = regex.Match( line ).Groups[2].ToString( );
				message = String.Format( "Argument \"{1}\" for {0} command is not valid, as {0} does not accept arguments at all", cmd, cla );
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}

			#endregion Arguments not required
		}

		public static void CheckVulnerabilities( string line )
		{
			string pattern;
			Regex regex;

			// Unquoted %CD% code insertion vulnerability
			#region Code insertion
			if ( !incomment )
			{
				pattern = @"[^""%!](([%!])(CD|__CD__)(:~\d+(,\d+)?|:[^\2\n\r]+=[^\2\n\r]*)?\2)";
				regex = new Regex( pattern, ignorecase );
				if ( regex.IsMatch( line ) )
				{
					string cd = regex.Match( line ).Groups[1].ToString( ).ToUpper( );
					message = String.Format( "Unquoted {0} makes the code vulnerable to code insertion (see http://www.thesecurityfactory.be/command-injection-windows.html)", cd );
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
				else
				{
					pattern = @"[^""](([%!])([%!])(CD|__CD__)(:~\d+(,\d+)?|:[^\2\3\n\r]+=[^\2\3\n\r]*)?\3\2)";
					regex = new Regex( pattern, ignorecase );
					if ( regex.IsMatch( line ) )
					{
						string cd = regex.Match( line ).Groups[1].ToString( ).ToUpper( );
						message = String.Format( "Unquoted {0} makes the code vulnerable to code insertion (see http://www.thesecurityfactory.be/command-injection-windows.html)", cd );
						allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						errmsg += String.Format( "\n{0}.", message );
						errinline = true;
					}
				}
			}
			#endregion Code insertion

			// SET /P vulnerability
			#region SET /P

			pattern = @"(^|\b)SET\s+/P\s+""?\w{1,16}\s*=";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( line ) )
			{
				message = "SET /P could make your code vulnerable to exploits (see http://www.robvanderwoude.com/battech_inputvalidation.php#SetP)";
				allbadpr += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				badprmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}


			#endregion SET /P
		}

		public static void CloseHTML( )
		{
			if ( log2html )
			{
				htmlstream.WriteLine( "\n</pre>" );
				htmlstream.WriteLine( "</body>" );
				htmlstream.Write( "</html>" );
				htmlstream.Close( );
				htmlopen = false;
			}
		}

		public static void CollectLabels( )
		{
			string pattern;
			Regex regex;

			pattern = @"(?:^|\n|\r)\s*:([\w\.\[\]/+\-\(\)\{\}]{1,127})";
			regex = new Regex( pattern );
			if ( regex.IsMatch( allsrc_nocomments ) )
			{
				foreach ( Match match in regex.Matches( allsrc_nocomments ) )
				{
					labels.Add( match.Groups[1].ToString( ) );
					upcaselabels.Add( match.Groups[1].ToString( ).ToUpper( ) );
				}
			}
		}

		public static void CollectEnvironmentVariables( )
		{
			string pattern;
			Regex regex;

			// Static system environment variables
			foreach ( string envvar in sysvarpattern.Split( '|' ) )
			{
				envvars.Add( envvar );
				upcaseenvvars.Add( envvar.ToUpper( ) );
			}

			// Dynamic system environment variables
			foreach ( string envvar in dynvarpattern.Split( '|' ) )
			{
				envvars.Add( envvar );
				upcaseenvvars.Add( envvar.ToUpper( ) );
			}

			// Environment variables SET in the source code with "plain" SET statement
			pattern = @"(?:^|\b)SET\s+(\w{1," + maxvarlen + @"})=";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( allsrc_nocomments ) )
			{
				foreach ( Match match in regex.Matches( allsrc_nocomments ) )
				{
					envvars.Add( match.Groups[1].ToString( ) );
					upcaseenvvars.Add( match.Groups[1].ToString( ).ToUpper( ) );
				}
			}

			// Environment variables SET in the source code with SET /A or SET /P statement
			pattern = @"(?:^|\b)SET\s+(?:/[AP]\s+)?""?(\w{1," + maxvarlen + @"})\s*=";
			regex = new Regex( pattern, ignorecase );
			if ( regex.IsMatch( allsrc_nocomments ) )
			{
				foreach ( Match match in regex.Matches( allsrc_nocomments ) )
				{
					if ( !upcaseenvvars.Contains( match.Groups[1].ToString( ).ToUpper( ) ) )
					{
						envvars.Add( match.Groups[1].ToString( ) );
						upcaseenvvars.Add( match.Groups[1].ToString( ).ToUpper( ) );
					}
				}
			}

			// Include local environment variables if /L command line switch was used
			if ( includelocalvars )
			{
				foreach ( string envvar in Environment.GetEnvironmentVariables( ).Keys )
				{
					if ( !upcaseenvvars.Contains( envvar ) )
					{
						envvars.Add( envvar );
						upcaseenvvars.Add( envvar.ToUpper( ) );
					}
				}
			}

			// All loacal environment variables
			foreach ( string envvar in Environment.GetEnvironmentVariables( ).Keys )
			{
				if ( !localenvvars.Contains( envvar.ToUpper( ) ) )
				{
					localenvvars.Add( envvar.ToUpper( ) );
				}
			}
		}

		public static void DisplayLineNumber( int num )
		{
			if ( dispnums )
			{
				Console.BackgroundColor = linenumbgcolor;
				Console.ForegroundColor = linenumfgcolor;
				if ( num == lastline )
				{
					Console.Write( "{0,4}", String.Empty );
					WriteLineHTML( String.Format( "{0,4}", String.Empty ) );
				}
				else
				{
					Console.Write( "{0,4}", num );
					WriteLineHTML( String.Format( "{0,4}", num ) );
				}
				Console.BackgroundColor = windowbgcolor;
				Console.ForegroundColor = windowfgcolor;
				Console.Write( " " );
				lastline = num;
			}
		}

		public static void DisplayMessagesPerLine( string line )
		{
			bool padline = true;
			string blankline = new String( ' ', Console.WindowWidth );
			string msgline;

			if ( errinline )
			{
				if ( lasterrline != linenum )
				{
					lineswitherrors += 1;
				}
				foreach ( string error in errmsg.Split( "\n\r".ToCharArray( ) ) )
				{
					if ( !String.IsNullOrWhiteSpace( error ) )
					{
						if ( wrap )
						{
							msgline = WordWrap( ( error ).Replace( "\t", " ERROR:   " ), padline );
						}
						else
						{
							msgline = ( error + blankline ).Replace( "\t", " ERROR:   " ).Substring( 0, Console.WindowWidth - 1 );
						}
						Console.BackgroundColor = warningbgcolor;
						Console.ForegroundColor = warningfgcolor;
						Console.Write( msgline );
						WriteLineHTML( msgline );
						Console.ResetColor( );
						Console.WriteLine( );
					}
				}
				foreach ( string badpractice in badprmsg.Split( '\n' ) )
				{
					if ( !String.IsNullOrWhiteSpace( badpractice ) )
					{
						if ( wrap )
						{
							msgline = WordWrap( ( badpractice ).Replace( "\t", " WARNING: " ), padline );
						}
						else
						{
							msgline = ( badpractice + blankline ).Replace( "\t", " WARNING: " ).Substring( 0, Console.WindowWidth - 1 );
						}
						Console.BackgroundColor = badprbgcolor;
						Console.ForegroundColor = badprfgcolor;
						Console.Write( msgline );
						WriteLineHTML( msgline );
						Console.ResetColor( );
						Console.WriteLine( );
					}
				}
				foreach ( string tip in tipsmsg.Split( '\n' ) )
				{
					if ( !String.IsNullOrWhiteSpace( tip ) )
					{
						if ( wrap )
						{
							msgline = WordWrap( ( tip ).Replace( "\t", " TIP:     " ), padline );
						}
						else
						{
							msgline = ( tip + blankline ).Replace( "\t", " TIP:     " ).Substring( 0, Console.WindowWidth - 1 );
						}
						Console.BackgroundColor = tipsbgcolor;
						Console.ForegroundColor = tipsfgcolor;
						Console.Write( msgline );
						WriteLineHTML( msgline );
						Console.ResetColor( );
						Console.WriteLine( );
					}
				}
				errinline = false;
				lasterrline = linenum;
				rc = linenum;
			}
		}

		public static void DisplayMessagesSummary( )
		{
			// Summary
			if ( lineswitherrors == 1 )
			{
				allerrsum += "\n1   line generated a warning and should be examined";
			}
			if ( lineswitherrors > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} lines generated warnings and should be examined", lineswitherrors );
			}
			// Unterminated %
			if ( unterminatedpercentsigns == 1 )
			{
				allerrsum += "\n1   unterminated percent sign was found";
			}
			if ( unterminatedpercentsigns > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} unterminated percent signs were found", unterminatedpercentsigns );
			}
			// Unterminated !
			if ( unterminatedexclamations == 1 )
			{
				allerrsum += "\n1   unterminated exclamation mark was found while delayed variable expansion was enabled";
			}
			if ( unterminatedexclamations > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} unterminated exclamation marks were found while delayed variable expansion was enabled", unterminatedexclamations );
			}
			// Unterminated "
			if ( unterminateddoublequotes == 1 )
			{
				allerrsum += String.Format( "\n1   unterminated doublequote was found", unterminateddoublequotes );
			}
			if ( unterminateddoublequotes > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} unterminated doublequotes were found", unterminateddoublequotes );
			}
			// Unterminated '
			if ( unterminatedsinglequotes == 1 )
			{
				allerrsum += String.Format( "\n1   unterminated singlequote was found in a FOR /F loop", unterminatedsinglequotes );
			}
			if ( unterminatedsinglequotes > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} unterminated singlequotes were found in FOR /F loops", unterminatedsinglequotes );
			}
			// Undefined environment variables
			string ignoredmsg = ( includelocalvars ? String.Empty : " (ignoring local environment variables)" );
			if ( envvarerrors.Count == 1 )
			{
				allerrsum += String.Format( "\n1   undefined variable was detected{0}: {1}", ignoredmsg, envvarerrors[0] );
			}
			if ( envvarerrors.Count > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} undefined variables were detected{1}: {2}", envvarerrors.Count, ignoredmsg, String.Join( ", ", envvarerrors ) );
			}
			// Undefined labels
			if ( gotoerrors.Count == 1 )
			{
				allerrsum += String.Format( "\n1   label was missing: {1}", gotoerrors[0] );
			}
			if ( gotoerrors.Count > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} labels were missing: {1}", gotoerrors.Count, String.Join( ", ", gotoerrors ) );
			}
			// Undefined subroutines
			if ( callerrors.Count == 1 )
			{
				allerrsum += String.Format( "\n1   subroutine label was missing (note that subroutine labels are case sensitive): {0}", callerrors[0] );
			}
			if ( callerrors.Count > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} subroutine labels were missing (note that subroutine labels are case sensitive): {1}", callerrors.Count, String.Join( ", ", callerrors ) );
			}
			// Obsolete commands
			if ( obsoletecmd == 1 )
			{
				allerrsum += "\n1   obsolete or 16-bit command was found";
			}
			if ( obsoletecmd > 1 )
			{
				allerrsum += String.Format( "\n{0,-3} obsolete and/or 16-bit commands were found", obsoletecmd );
			}
			// Unterminated parentheses
			if ( parenthesis > 0 )
			{
				allerrsum += "\nOpening parenthesis outnumber closing parenthesis by " + parenthesis;
			}
			if ( parenthesis < 0 )
			{
				allerrsum += "\nClosing parenthesis outnumber opening parenthesis by " + Math.Abs( parenthesis );
			}
			// Unterminated SETLOCALs
			if ( setlocal > 0 )
			{
				allerrsum += "\nSETLOCALs outnumber ENDLOCALs by " + setlocal;
			}
			if ( setlocal < 0 )
			{
				allerrsum += "\nENDLOCALs outnumber SETLOCALs by " + Math.Abs( setlocal );
			}

			// Display warnings if applicable
			if ( !String.IsNullOrWhiteSpace( allerrors ) )
			{
				allerrors = String.Format( "\nERRORS / VULNERABILITIES:{0}\n", allerrors );
			}
			if ( !String.IsNullOrWhiteSpace( allbadpr ) )
			{
				allerrors = String.Format( "{0}\nWARNINGS / TO BE INVESTIGATED:{1}\n", allerrors, allbadpr );
			}
			if ( !String.IsNullOrWhiteSpace( alltips ) )
			{
				allerrors = String.Format( "{0}\nTIPS / BEST PRACTICES:{1}\n", allerrors, alltips );
			}
			if ( !String.IsNullOrWhiteSpace( allerrsum ) )
			{
				allerrors = String.Format( "{0}\nSUMMARY:{1}\n", allerrors, allerrsum );
			}

			if ( !String.IsNullOrEmpty( allerrors ) )
			{
				allerrors += "\n\nNote that some warnings are only displayed once. Correct the errors and run this test again.";
				Console.ResetColor( );
				Console.WriteLine( "\n" );
				Console.WriteLine( "Time      :  {0}", DateTime.Now.ToString( "yyyy-MM-dd HH:mm:ss" ) );
				Console.WriteLine( "Program   :  BatCodeCheck, Version {0}", progver );
				Console.WriteLine( "Arguments :  {0}", allargs );
				Console.WriteLine( "File name :  \"{0}\"", Path.GetFullPath( source ) );
				Console.WriteLine( "File date :  {0}", File.GetLastWriteTime( source ).ToString( "yyyy-MM-dd HH:mm:ss" ) );
				if ( envvarerrors.Count > 0 )
				{
					Console.WriteLine( "Local environment variables are {0}", ( includelocalvars ? "included" : "ignored" ) );
				}
				Console.WriteLine( );
				Console.BackgroundColor = reportbgcolor;
				Console.ForegroundColor = reportfgcolor;
				if ( wrap )
				{
					string[] all_errors = allerrors.Split( "\n\r".ToCharArray( ) );
					foreach ( string all_err in all_errors )
					{
						Console.WriteLine( WordWrap( all_err, false ) );
					}
				}
				else
				{
					Console.WriteLine( allerrors );
				}
				WriteLineHTML( allerrors );
				Console.ResetColor( );
				Console.WriteLine( );
				rc = Math.Max( 1, rc );
				if ( logging )
				{
					StreamWriter log = new StreamWriter( logfile, !replacelog );
					log.WriteLine( "Time      :  {0}", DateTime.Now.ToString( "yyyy-MM-dd HH:mm:ss" ) );
					log.WriteLine( "Program   :  BatCodeCheck, Version {0}", progver );
					log.WriteLine( "Arguments :  {0}", allargs );
					log.WriteLine( "File name :  \"{0}\"", Path.GetFullPath( source ) );
					log.WriteLine( "File date :  {0}", File.GetLastWriteTime( source ).ToString( "yyyy-MM-dd HH:mm:ss" ) );
					if ( envvarerrors.Count > 0 )
					{
						log.WriteLine( "Local environment variables are {0}", ( includelocalvars ? "included" : "ignored" ) );
					}
					log.WriteLine( allerrors + "\n\n" );
					log.Close( );
				}
			}
		}

		public static string EscapedHTML( char chr )
		{
			switch ( chr )
			{
				case '&':
					return "&amp;";
				case '>':
					return "&gt;";
				case '<':
					return "&lt;";
				default:
					return String.Format( "{0}", chr );
			}
		}

		public static void OpenHTML( )
		{
			if ( log2html )
			{
				htmlstream = new StreamWriter( htmlfile );
				htmlopen = true;
				htmlstream.WriteLine( "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">" );
				htmlstream.WriteLine( "<html>" );
				htmlstream.WriteLine( "<head>" );
				htmlstream.WriteLine( "<title>BatCodeCheck Version {0} report for {1}</title>", progver, Path.GetFileName( source ) );
				htmlstream.WriteLine( "<style type=\"text/css\">" );
				htmlstream.WriteLine( "body" );
				htmlstream.WriteLine( "{" );
				htmlstream.WriteLine( "\tbackground-color: {0};", windowbgcolor.ToString( ).ToLower( ) );
				htmlstream.WriteLine( "\tcolor: {0};", windowfgcolor.ToString( ).ToLower( ) );
				htmlstream.WriteLine( "}" );
				htmlstream.WriteLine( "</style>" );
				htmlstream.WriteLine( "</head>" );
				htmlstream.WriteLine( "<body>" );
				htmlstream.WriteLine( "<pre>" );
				htmlstream.WriteLine( "<span style=\"color: white;\">Time      :  {0}", DateTime.Now.ToString( "yyyy-MM-dd HH:mm:ss" ) );
				htmlstream.WriteLine( "Program   :  BatCodeCheck, Version {0}", progver );
				htmlstream.WriteLine( "Arguments :  {0}", allargs );
				htmlstream.WriteLine( "File name :  \"{0}\"", Path.GetFullPath( source ) );
				htmlstream.Write( "File date :  {0}", File.GetLastWriteTime( source ).ToString( "yyyy-MM-dd HH:mm:ss" ) );
				if ( envvarerrors.Count > 0 )
				{
					htmlstream.Write( "\nLocal environment variables are {0}", ( includelocalvars ? "included" : "ignored" ) );
				}
				htmlstream.WriteLine( "</span>\n" );
			}
		}

		public static void ParseLine( string line )
		{
			ResetInlineVariables( );
			DisplayLineNumber( linenum );
			CheckCommonMistakes( line );
			CheckCommandLineArguments( line );
			CheckBadPractices( line );
			CheckBestPractices( line );
			ParseLineAndHighlight( line );
			CheckVulnerabilities( line );
			DisplayMessagesPerLine( line );
		}

		public static void ParseLineAndHighlight( string line )
		{
			// Comments are highlighted and not interpreted at all.
			// This may spell trouble in case of multiple commands on a single line.
			if ( new Regex( @"^\s*(REM($|\s)|::)", ignorecase ).IsMatch( line ) )
			{
				Console.ForegroundColor = commentfgscolor;
				Console.WriteLine( line );
				WriteHTML( line );
				Console.ResetColor( );
			}
			// do not highlight ECHO ON or ECHO OFF as ECHOed text
			else if ( new Regex( @"^\s*@?ECHO\s+(ON|OFF)\s*$", ignorecase ).IsMatch( line ) )
			{
				Console.ResetColor( );
				Console.WriteLine( line );
				WriteHTML( line );
			}
			// check if delayed variable expansion is enabled (will choke on nested SETLOCALs)
			else if ( new Regex( @"^\s*SETLOCAL\s+((EN|DIS)ABLEEXTENSIONS\s+)?ENABLEDELAYEDEXPANSION(\b|$)", ignorecase ).IsMatch( line ) )
			{
				delayedvarexp = true;
				delayedvarglobal = true;
				Console.ResetColor( );
				Console.WriteLine( line );
				WriteHTML( line );
			}
			// check if delayed variable expansion is disabled (will choke on nested SETLOCALs)
			else if ( new Regex( @"^\s*ENDLOCAL\b", ignorecase ).IsMatch( line ) )
			{
				delayedvarexp = false;
				Console.ResetColor( );
				Console.WriteLine( line );
				WriteHTML( line );
			}
			else
			{
				ParseLinePerCharacter( line );
			}
		}

		public static void ParseLinePerCharacter( string line )
		{
			#region Initialize Inline Variables

			//string badprmsg = String.Empty;
			//string errmsg = String.Empty;
			//string tipsmsg = String.Empty;
			//string message = String.Empty;
			string part = String.Empty;
			string buildword = String.Empty;
			string lastword = String.Empty;
			int doublequotes = 0;
			int singlequotes = 0;
			bool doublepercent = false;
			bool doublequoted = false;
			bool echoed = false;
			bool escnext = false;
			bool forfloop = false;
			bool inexcl = false;
			bool inperc = false;
			bool isparenthesis = false;
			bool redirection = false;
			bool singlequoted = false;
			bool tempdblquoted = false;
			bool tempinexcl = false;
			bool tempinperc = false;
			bool tempsngquoted = false;
			bool tildestr = false;

			#endregion Initialize Inline Variables

			// check if inside a FOR /F loop
			forfloop = new Regex( @"\bFOR\s+/F\b", ignorecase ).IsMatch( line );

			char prevchr = ' ';
			int index = -1;

			foreach ( char chr in line )
			{
				index += 1;
				switch ( chr )
				{
					case '"':
						doublequoted = ( doublequoted ^ !escnext ) && !echoed;
						if ( !echoed )
						{
							doublequotes += 1;
						}
						escnext = false;
						inperc = false;
						redirection = false;
						tildestr = false;
						break;
					case (char) 39:
						singlequoted = ( !singlequoted ^ escnext ) && !echoed;
						if ( !echoed && ( doublequotes % 2 == 0 ) )
						{
							singlequotes += 1;
						}
						escnext = false;
						inperc = false;
						redirection = false;
						tildestr = false;
						break;
					case '^':
						escnext = ( prevchr != chr );
						inperc = false;
						tildestr = false;
						break;
					case '%':
						if ( prevchr == '%' )
						{
							doublepercent = true;
						}
						else
						{
							doublepercent = false;
							inperc = !inperc;
						}
						escnext = false;
						redirection = false;
						tildestr = false;
						break;
					case '!':
						if ( delayedvarexp )
						{
							inexcl = !inexcl;
						}
						escnext = false;
						inperc = false;
						redirection = false;
						tildestr = false;
						break;
					case '~':
						if ( prevchr == '%' )
						{
							inperc = false;
							tildestr = true;
						}
						escnext = false;
						redirection = false;
						break;
					case '&':
						if ( prevchr == chr )
						{
							doublequoted = false;
							echoed = false;
							inperc = false;
							redirection = false;
						}
						else
						{
							redirection = !escnext;
						}
						if ( singlequoted && redirection )
						{
							message = "Unescaped ampersand(s) in singlequoted text (FOR /F loop" + ( forfloop ? String.Empty : "?" ) + ")";
							if ( errmsg.IndexOf( message ) > -1 )
							{
								allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
								errmsg += String.Format( "\n{0}.", message );
							}
							errinline = true;
						}
						escnext = false;
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case '|':
						if ( prevchr == chr )
						{
							doublequoted = false;
							echoed = false;
							inperc = false;
							redirection = false;
						}
						else
						{
							redirection = !escnext;
						}
						if ( singlequoted && redirection )
						{
							message = "Unescaped pipe symbol(s) in singlequoted text (FOR /F loop" + ( forfloop ? String.Empty : "?" ) + ")";
							if ( errmsg.IndexOf( message ) > -1 )
							{
								allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
								errmsg += String.Format( "\n{0}.", message );
							}
							errinline = true;
						}
						escnext = false;
						echoed = false;
						incomment = false;
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case '>':
						redirection = !escnext;
						if ( singlequoted && redirection )
						{
							message = "Unescaped \"greater than\" symbol(s) in singlequoted text (FOR /F loop" + ( forfloop ? String.Empty : "?" ) + ")";
							if ( errmsg.IndexOf( message ) > -1 )
							{
								allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
								errmsg += String.Format( "\n{0}.", message );
							}
							errinline = true;
						}
						escnext = false;
						echoed = false;
						incomment = false;
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case '<':
						redirection = !escnext;
						if ( singlequoted && redirection )
						{
							message = "Unescaped \"less than\" symbol(s) in singlequoted text (FOR /F loop" + ( forfloop ? String.Empty : "?" ) + ")";
							if ( errmsg.IndexOf( message ) > -1 )
							{
								allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
								errmsg += String.Format( "\n{0}.", message );
							}
							errinline = true;
						}
						escnext = false;
						inexcl = false;
						inperc = false;
						tildestr = false;
						break;
					case ' ':
					case '\t':
						if ( inexcl )
						{
							unterminatedexclamations += 1;
							message = "Unterminated exclamation marks or whitespace in (delayed) variable name";
							if ( errmsg.IndexOf( message ) > -1 )
							{
								allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
								errmsg += String.Format( "\n{0}.", message );
							}
							errinline = true;
						}
						if ( inperc )
							escnext = false;
						inexcl = false;
						inperc = false;
						redirection = false;
						tildestr = false;
						break;
					case '(':
						if ( !echoed )
						{
							parenthesis += 1;
						}
						inexcl = false;
						inperc = false;
						isparenthesis = true;
						redirection = false;
						tildestr = false;
						break;
					case ')':
						if ( !echoed )
						{
							parenthesis -= 1;
						}
						if ( parenthesis < 0 )
						{
							message = "Too many closing parenthesis";
							if ( allerrors.IndexOf( message ) == -1 )
							{
								allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
								errmsg += String.Format( "\n{0}.", message );
								errinline = true;
							}
						}
						inexcl = false;
						inperc = false;
						isparenthesis = true;
						redirection = false;
						tildestr = false;
						break;
					case 'a':
					case 'd':
					case 'f':
					case 'n':
					case 'p':
					case 's':
					case 't':
					case 'x':
					case 'z':
						// "$PATH:" is ignored in the highlighting
						if ( ( prevchr == '%' ) || tildestr )
						{
							inperc = false;
							tildestr = true;
						}
						escnext = false;
						redirection = false;
						break;
					case '0':
					case '1':
					case '2':
					case '3':
					case '4':
					case '5':
					case '6':
					case '7':
					case '8':
					case '9':
						if ( ( prevchr == '%' ) || tildestr )
						{
							inperc = false;
							tildestr = true;
						}
						escnext = false;
						redirection = false;
						break;
					default:
						escnext = false;
						redirection = false;
						tildestr = false;
						break;
				}

				// check for unescaped redirection symbols in FOR /F loops
				if ( redirection && singlequoted && ( parenthesis % 2 == 1 ) )
				{
					message = "Unescaped redirection symbol(s) in single quoted text (FOR /F loop?)";
					if ( errmsg.IndexOf( message ) > -1 )
					{
						allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
						errmsg += String.Format( "\n{0}.", message );
					}
					errinline = true;
				}

				// check if we are dealing with ECHOed text or comments
				if ( chr == ' ' || chr == '\t' )
				{
					lastword = buildword.ToUpper( ).Trim( );
					buildword = String.Empty;
				}
				else
				{
					buildword += chr.ToString( );
				}
				if ( lastword == "ECHO" || lastword == "@ECHO" )
				{
					echoed = true;
				}
				else if ( lastword == "REM" || lastword == "::" )
				{
					incomment = true;
				}

				// as soon as an unescaped redirection symbol is encountered, we no longer have ECHOed text
				if ( redirection )
				{
					echoed = false;
				}

				// correctly highlight the character we just parsed
				if ( redirection )
				{
					// redirection symbols and parenthesis are highlighted in red
					Console.ForegroundColor = redirectionfgcolor;
				}
				else if ( isparenthesis && !echoed )
				{
					// redirection symbols and parenthesis are highlighted in red
					Console.ForegroundColor = parenthesisfgcolor;
				}
				else if ( ( ( prevchr == (char) 39 ) && ( chr == ')' ) ) || singlequoted || tempsngquoted )
				{
					// singlequoted text in parenthesis is highlighted in dark gray
					Console.ForegroundColor = singlequotedfgcolor;
				}
				else if ( inexcl || inperc || tildestr || doublepercent || tempinexcl || tempinperc )
				{
					// variables and parameters are highlighted in green
					Console.ForegroundColor = variablesfgcolor;
				}
				else if ( echoed )
				{
					// ECHOed text is highlighted in cyan, with the exception of variables
					Console.ForegroundColor = echoedtextfgcolor;
				}
				else if ( doublequoted || tempdblquoted )
				{
					Console.ForegroundColor = doublequotedfgcolor;
				}
				else
				{
					Console.ResetColor( );
				}
				Console.Write( chr );
				WriteHTML( EscapedHTML( chr ) );
				switch ( chr )
				{
					case '"':
						tempdblquoted = doublequoted;
						redirection = false;
						tildestr = false;
						break;
					case (char) 39:
						tempsngquoted = singlequoted;
						redirection = false;
						tildestr = false;
						break;
					case '%':
						tempinperc = inperc;
						redirection = false;
						break;
					case '!':
						if ( prevchr != '^' )
						{
							tempinexcl = inexcl;
							redirection = false;
						}
						break;
					case '^':
						if ( prevchr == chr )
						{
							prevchr = ' ';
						}
						escnext = false;
						tildestr = false;
						break;
					case '&':
					case '|':
					case '>':
					case '<':
						redirection = true;
						escnext = false;
						tildestr = false;
						break;
					case '0':
					case '1':
					case '2':
					case '3':
					case '4':
					case '5':
					case '6':
					case '7':
					case '8':
					case '9':
						if ( inperc && tildestr )
						{
							inperc = false;
						}
						tildestr = false;
						break;
					case ' ':
					case '\t':
					case '.':
						tildestr = false;
						break;
					default:
						redirection = false;
						break;
				}
				isparenthesis = false;
				prevchr = chr;
			}
			Console.WriteLine( );
			if ( doublequotes % 2 == 1 )
			{
				unterminateddoublequotes += 1;
				message = "Unterminated doublequotes";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}
			if ( singlequotes % 2 == 1 )
			{
				unterminatedsinglequotes += 1;
				message = "Unterminated singlequotes";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}
			if ( inperc && !tildestr )
			{
				unterminatedpercentsigns += 1;
				message = "Unterminated percent signs";
				allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
				errmsg += String.Format( "\n{0}.", message );
				errinline = true;
			}
			if ( inexcl && delayedvarexp )
			{
				int exclmt = new Regex( @"!" ).Matches( line ).Count;
				int escexcl = new Regex( @"\^\^!" ).Matches( line ).Count; // Exclude escaped exclamation marks
				if ( ( exclmt - escexcl ) % 2 == 1 )
				{
					unterminatedexclamations += 1;
					message = "Unterminated exclamation marks";
					allerrors += String.Format( "\nLine {1,5:0}:\t{0}", message, linenum );
					errmsg += String.Format( "\n{0}.", message );
					errinline = true;
				}
			}
		}

		public static void ReadSource( string file )
		{
			StreamReader src = new StreamReader( file );
			// Read batch source as pure ASCII, which is an absolute requirement for batch files
			allsrc = Encoding.ASCII.GetString( Encoding.ASCII.GetBytes( src.ReadToEnd( ) ) );
			src.Close( );
			Regex rxcmnt = new Regex( @"(?:^|\n|\r|\(|&)\s*((?:REM|::)[^\n\r]+)", ignorecase );
			allsrc_nocomments = rxcmnt.Replace( allsrc, String.Empty );
		}

		public static void ResetInlineVariables( )
		{
			badprmsg = String.Empty;
			errinline = false;
			errmsg = String.Empty;
			tipsmsg = String.Empty;
			message = String.Empty;
			part = String.Empty;
			buildword = String.Empty;
			lastword = String.Empty;
		}

		public static void RestoreConsoleColors( )
		{
			Console.ForegroundColor = windowfgcolor;
			Console.BackgroundColor = windowbgcolor;
		}

		public static string Which( string prog )
		{
			bool found = false;
			foreach ( string folder in path )
			{
				if ( !found )
				{
					if ( !string.IsNullOrWhiteSpace( folder ) )
					{
						string dir = ( folder + "\\" ).Replace( "\\\\", "\\" );
						foreach ( string ext in pathext )
						{
							if ( !found )
							{
								// The EXTERNAL program FILE to be searched MUST have an extension, either
								// specified on the command line or one of the extensions listed in PATHEXT.
								if ( ( prog + ext ).IndexOf( '.' ) > -1 )
								{
									if ( File.Exists( dir + prog + ext ) )
									{
										return dir + prog + ext;
									}
								}
							}
						}
					}
				}
			}
			return String.Empty;
		}

		public static string WordWrap( string input, bool padright = false )
		{
			string output = String.Empty;
			string blankline = new String( ' ', Console.WindowWidth );
			while ( !String.IsNullOrEmpty( input ) )
			{
				int brpos;
				if ( input.Length < Console.WindowWidth )
				{
					if ( padright )
					{
						input = ( input + blankline ).Substring( 0, Console.WindowWidth - 1 );
						brpos = Console.WindowWidth - 1;
					}
					else
					{
						brpos = input.Length;
					}
				}
				else
				{
					brpos = input.Substring( 0, Math.Min( Console.WindowWidth - 1, input.Length ) ).LastIndexOfAny( ". -".ToCharArray( ) );
				}
				// Just break at window width if word length exceeds window width
				if ( brpos == -1 )
				{
					brpos = Math.Min( Console.WindowWidth - 1, input.Length );
				}
				string msgline = input.Substring( 0, Math.Min( brpos + 1, input.Length ) ).Trim( );
				if ( padright )
				{
					msgline = ( msgline + blankline ).Substring( 0, Console.WindowWidth - 1 );
				}
				output += msgline + "\n";
				input = input.Substring( Math.Min( brpos + 1, input.Length ) ).Trim( );
			}
			return output.TrimEnd( "\n\r".ToCharArray( ) );
		}

		public static void WriteHTML( string text )
		{
			if ( log2html )
			{
				if ( !htmlopen )
				{
					OpenHTML( );
				}
				htmlstream.Write( String.Format( "<span style=\"background-color: {0}; color: {1};\">{2}</span>", Console.BackgroundColor.ToString( ).ToLower( ), Console.ForegroundColor.ToString( ).ToLower( ), text ) );
			}
		}

		public static void WriteLineHTML( string text )
		{
			if ( log2html )
			{
				WriteHTML( String.Format( "\n{0}", text ) );
			}
		}

		#endregion Subroutines


		#region Error Handling

		public static int WriteError( string errorMessage = null )
		{
			if ( htmlopen )
			{
				htmlstream.Close( );
				File.Delete( htmlfile );
			}

			if ( !String.IsNullOrEmpty( errorMessage ) )
			{
				Console.Error.WriteLine( );
				Console.ForegroundColor = ConsoleColor.Red;
				Console.Error.Write( "ERROR:\t" );
				Console.ForegroundColor = ConsoleColor.White;
				Console.Error.WriteLine( errorMessage );
				Console.ResetColor( );
			}

			/*
			BatCodeCheck,  Version 0.32.1 beta,  Unlicensed
			Search batch source code for common errors

			Usage:   BATCODECHECK  batchfile [ logging ] [ options ]

			or:      BATCODECHECK  [ batchfile ]  /I

			Where:   batchfile       is the batch file to be checked and highlighted
			Logging: /L[:"logfile"]  Log results in ASCII format, replace file if it exists
			         /H[:"htmlfile"] log results in HTML format, replace file if it exists
			                         (default output file names equal batchfile name, with
			                         extension .log or .html)
			Options: /E              include local Environment in defined variables list
			         /I              open Interactive settings dialog (licensed version)
			         /S              Split one-liners into separate command lines
			         /T              add a Timestamp to the default output file names
			         /W              Wrap messages in source code (default: chop them)

			Notes:   The source code is displayed with highlighted ECHOed text,
			         comments, quoted strings, redirection, parenthesis and variables.
			         A warning message will be displayed if code errors were found.
			         Warning messages in the source code are chopped by default, and
			         repeated again (wrapped) at the end of the source code.
			         A non-zero return code means something was wrong, either on
			         the command line or in the source code. A return code greater
			         than 1 indicates the last line where an error was detected.
			         If no errors are detected, nothing will be logged.
			         False positives cannot be prevented entirely, use common sense
			         when evaluating the warnings and error messages.

			Written by Rob van der Woude
			http://www.robvanderwoude.com
			*/

			Console.Error.WriteLine( );
			Console.Error.WriteLine( "BatCodeCheck,  Version {0}{1}", progver, ( licensed ? String.Empty : ",  (unlicensed)" ) );
			Console.Error.WriteLine( "Search batch source code for common errors" );
			Console.Error.WriteLine( );

			Console.Error.Write( "Or:      " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.WriteLine( "BATCODECHECK  batchfile [ logging ] [ options ]" );
			Console.ResetColor( );

			Console.Error.WriteLine( );

			Console.Error.Write( "Usage:   " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.WriteLine( "BATCODECHECK  [ batchfile ]  /I" );
			Console.ResetColor( );

			Console.Error.WriteLine( );

			Console.Error.Write( "Where:   " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "batchfile" );
			Console.ResetColor( );
			Console.Error.Write( "       is the " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "batch file" );
			Console.ResetColor( );
			Console.Error.WriteLine( " to be checked and highlighted" );

			Console.Error.Write( "Logging: " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/L[:\"logfile\"]  L" );
			Console.ResetColor( );
			Console.Error.WriteLine( "og results in ASCII format, replace file if it exists" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /H[:\"htmlfile\"]" );
			Console.ResetColor( );
			Console.Error.Write( " log results in " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "H" );
			Console.ResetColor( );
			Console.Error.WriteLine( "TML format, replace file if it exists" );

			Console.Error.Write( "                         (" );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "default" );
			Console.ResetColor( );
			Console.Error.Write( " output file names equal " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "batchfile" );
			Console.ResetColor( );
			Console.Error.WriteLine( " name, with" );

			Console.Error.Write( "                         extension " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( ".log" );
			Console.ResetColor( );
			Console.Error.Write( " or " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( ".html" );
			Console.ResetColor( );
			Console.Error.WriteLine( ")" );

			Console.Error.Write( "Options: " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "/E" );
			Console.ResetColor( );
			Console.Error.Write( "              include local " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "E" );
			Console.ResetColor( );
			Console.Error.WriteLine( "nvironment in defined variables list" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /I" );
			Console.ResetColor( );
			Console.Error.Write( "              open " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "I" );
			Console.ResetColor( );
			Console.Error.WriteLine( "nteractive settings dialog (licensed version)" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /S              S" );
			Console.ResetColor( );
			Console.Error.WriteLine( "plit one-liners into separate command lines" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /T" );
			Console.ResetColor( );
			Console.Error.Write( "              add a " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "T" );
			Console.ResetColor( );
			Console.Error.Write( "imestamp to the " );
			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "default" );
			Console.ResetColor( );
			Console.Error.WriteLine( " output file names" );

			Console.ForegroundColor = ConsoleColor.White;
			Console.Error.Write( "         /W              W" );
			Console.ResetColor( );
			Console.Error.WriteLine( "rap messages in source code (default: chop them)" );

			Console.Error.WriteLine( );
			Console.Error.Write( "Notes:   The source code is displayed with highlighted " );
			Console.ForegroundColor = echoedtextfgcolor;
			Console.Error.Write( "ECHOed text" );
			Console.ResetColor( );
			Console.Error.WriteLine( "," );

			Console.ForegroundColor = commentfgscolor;
			Console.Error.Write( "         comments" );
			Console.ResetColor( );
			Console.Error.Write( ", " );
			Console.ForegroundColor = doublequotedfgcolor;
			Console.Error.Write( "quoted strings" );
			Console.ResetColor( );
			Console.Error.Write( ", " );
			Console.ForegroundColor = redirectionfgcolor;
			Console.Error.Write( "redirection" );
			Console.ResetColor( );
			Console.Error.Write( ", " );
			Console.ForegroundColor = parenthesisfgcolor;
			Console.Error.Write( "parenthesis" );
			Console.ResetColor( );
			Console.Error.Write( " and " );
			Console.ForegroundColor = variablesfgcolor;
			Console.Error.Write( "variables" );
			Console.ResetColor( );
			Console.Error.WriteLine( "." );

			Console.Error.WriteLine( "         A warning message will be displayed if code errors were found." );
			Console.Error.WriteLine( "         Warning messages in the source code are chopped by default, and" );
			Console.Error.WriteLine( "         repeated again (wrapped) at the end of the source code." );
			Console.Error.WriteLine( "         A non-zero return code means something was wrong, either on" );
			Console.Error.WriteLine( "         the command line or in the source code. A return code greater" );
			Console.Error.WriteLine( "         than 1 indicates the last line where an error was detected." );
			Console.Error.WriteLine( "         False positives cannot be prevented entirely, use common sense" );
			Console.Error.WriteLine( "         when evaluating the warnings and error messages." );
			Console.Error.WriteLine( );
			Console.Error.WriteLine( "Written by Rob van der Woude" );
			Console.Error.WriteLine( "http://www.robvanderwoude.com" );
			return 1;
		}

		#endregion Error Handling
	}
}
