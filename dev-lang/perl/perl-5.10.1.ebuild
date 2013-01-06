# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/perl/perl-5.10.1.ebuild,v 1.23 2012/01/02 22:52:21 zmedico Exp $

EAPI=2

inherit eutils alternatives flag-o-matic toolchain-funcs multilib

PATCH_VER=9

PERL_OLDVERSEN="5.10.0"

SHORT_PV="${PV%.*}"
MY_P="perl-${PV/_rc/-RC}"
MY_PV="${PV%_rc*}"

DESCRIPTION="Larry Wall's Practical Extraction and Report Language"

S="${WORKDIR}/${MY_P}"
SRC_URI="mirror://cpan/src/${MY_P}.tar.bz2
	mirror://gentoo/${MY_P}-${PATCH_VER}.tar.bz2
	http://dev.gentoo.org/~tove/files/${MY_P}-${PATCH_VER}.tar.bz2"
HOMEPAGE="http://www.perl.org/"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="berkdb build debug doc gdbm ithreads"

COMMON_DEPEND="berkdb? ( sys-libs/db )
	gdbm? ( >=sys-libs/gdbm-1.8.3 )
	>=sys-devel/libperl-5.10.1
	!!<sys-devel/libperl-5.10.1
	app-arch/bzip2
	sys-libs/zlib"
DEPEND="${COMMON_DEPEND}
	elibc_FreeBSD? ( sys-freebsd/freebsd-mk-defs )"
RDEPEND="${COMMON_DEPEND}"
PDEPEND=">=app-admin/perl-cleaner-2_pre090920"

dual_scripts() {
	src_remove_dual_scripts perl-core/Archive-Tar        1.52    ptar ptardiff
	src_remove_dual_scripts perl-core/Digest-SHA         5.47    shasum
	src_remove_dual_scripts perl-core/CPAN               1.9402  cpan
	src_remove_dual_scripts perl-core/CPANPLUS           0.88    cpanp cpan2dist cpanp-run-perl
	src_remove_dual_scripts perl-core/Encode             2.35    enc2xs piconv
	src_remove_dual_scripts perl-core/ExtUtils-MakeMaker 6.55_02 instmodsh
	src_remove_dual_scripts perl-core/Module-Build       0.34_02 config_data
	src_remove_dual_scripts perl-core/Module-CoreList    2.18    corelist
	src_remove_dual_scripts perl-core/PodParser          1.37    pod2usage podchecker podselect
	src_remove_dual_scripts perl-core/Test-Harness       3.17    prove
	src_remove_dual_scripts perl-core/podlators          2.2.2   pod2man pod2text
}

pkg_setup() {
	LIBPERL="libperl$(get_libname ${MY_PV})"

	if use ithreads ; then
		ewarn "THREADS WARNING:"
		ewarn "PLEASE NOTE: You are compiling ${MY_P} with"
		ewarn "interpreter-level threading enabled."
		ewarn "Threading is not supported by all applications "
		ewarn "that compile against perl. You use threading at "
		ewarn "your own discretion. "
		echo
	fi
	if has_version "~dev-lang/perl-5.8.8" ; then
		ewarn "UPDATE THE PERL MODULES:"
		ewarn "After updating dev-lang/perl you must reinstall"
		ewarn "the installed perl modules."
		ewarn "Use: perl-cleaner --all"
	elif has_version dev-lang/perl ; then
		# doesnot work
		#if ! has_version dev-lang/perl[ithreads=,debug=] ; then
		#if ! has_version dev-lang/perl[ithreads=] || ! has_version dev-lang/perl[debug=] ; then
		if (   use ithreads && ! has_version dev-lang/perl[ithreads]   ) || \
		   ( ! use ithreads &&   has_version dev-lang/perl[ithreads]   ) || \
		   (   use debug    && ! has_version dev-lang/perl[debug]      ) || \
		   ( ! use debug    &&   has_version dev-lang/perl[debug]      ) ; then
			ewarn "TOGGLED USE-FLAGS WARNING:"
			ewarn "You changed one of the use-flags ithreads or debug."
			ewarn "You must rebuild all perl-modules installed."
			ewarn "Use: perl-cleaner --modules ; perl-cleaner --force --libperl"
		fi
	fi
	dual_scripts
}

src_prepare() {
	EPATCH_SOURCE="${WORKDIR}/perl-patch" \
	EPATCH_SUFFIX="diff" \
	EPATCH_FORCE="yes" \
	epatch

	# pod/perltoc.pod fails
	ln -s ${LIBPERL} libperl$(get_libname ${SHORT_PV})
	ln -s ${LIBPERL} libperl$(get_libname )
}

myconf() {
	# the myconf array is declared in src_configure
	myconf=( "${myconf[@]}" "$@" )
}

src_configure() {
	declare -a myconf

	# some arches and -O do not mix :)
	use ppc && replace-flags -O? -O1
	# Perl has problems compiling with -Os in your flags with glibc
	use elibc_uclibc || replace-flags "-Os" "-O2"
	# This flag makes compiling crash in interesting ways
	filter-flags "-malign-double"
	# Fixes bug #97645
	use ppc && filter-flags "-mpowerpc-gpopt"
	# Fixes bug #143895 on gcc-4.1.1
	filter-flags "-fsched2-use-superblocks"

	# this is needed because gcc 3.3-compiled kernels will hang
	# the machine trying to run this test - check with `Kumba
	# <rac@gentoo.org> 2003.06.26
	use mips && myconf -Dd_u32align

	use sparc && myconf -Ud_longdbl

	export LC_ALL="C"
	[[ ${COLUMNS:-1} -ge 1 ]] || unset COLUMNS # bug #394091

	# 266337
	export BUILD_BZIP2=0
	export BZIP2_INCLUDE=/usr/include
	export BZIP2_LIB=/usr/$(get_libdir)
	cat <<-EOF > "${S}/ext/Compress-Raw-Zlib/config.in"
		BUILD_ZLIB = False
		INCLUDE = /usr/include
		LIB = /usr/$(get_libdir)

		OLD_ZLIB = False
		GZIP_OS_CODE = AUTO_DETECT
	EOF

	case ${CHOST} in
		*-freebsd*)   osname="freebsd" ;;
		*-dragonfly*) osname="dragonfly" ;;
		*-netbsd*)    osname="netbsd" ;;
		*-openbsd*)   osname="openbsd" ;;
		*-darwin*)    osname="darwin" ;;
		*)            osname="linux" ;;
	esac

	if use ithreads ; then
		mythreading="-multi"
		myconf -Dusethreads
		myarch=${CHOST}
		myarch="${myarch%%-*}-${osname}-thread"
	else
		myarch=${CHOST}
		myarch="${myarch%%-*}-${osname}"
	fi
	if use debug ; then
		myarch="${myarch}-debug"
	fi

	# allow either gdbm to provide ndbm (in <gdbm/ndbm.h>) or db1

	myndbm='U'
	mygdbm='U'
	mydb='U'

	if use gdbm ; then
		mygdbm='D'
		myndbm='D'
	fi
	if use berkdb ; then
		mydb='D'
		has_version '=sys-libs/db-1*' && myndbm='D'
	fi

	myconf "-${myndbm}i_ndbm" "-${mygdbm}i_gdbm" "-${mydb}i_db"

	if use alpha && [[ "$(tc-getCC)" = "ccc" ]] ; then
		ewarn "Perl will not be built with berkdb support, use gcc if you needed it..."
		myconf -Ui_db -Ui_ndbm
	fi

	if use debug ; then
		append-cflags "-g"
		myconf -DDEBUGGING
	fi

	local inclist=$(for v in ${PERL_OLDVERSEN}; do echo -n "${v} ${v}/${myarch}${mythreading}"; done )

	[[ ${ELIBC} == "FreeBSD" ]] && myconf "-Dlibc=/usr/$(get_libdir)/libc.a"

	if [[ $(get_libdir) != "lib" ]] ; then
		# We need to use " and not ', as the written config.sh use ' ...
		myconf "-Dlibpth=/usr/local/$(get_libdir) /$(get_libdir) /usr/$(get_libdir)"
	fi

	sh Configure \
		-des \
		-Duseshrplib \
		-Darchname="${myarch}" \
		-Dcc="$(tc-getCC)" \
		-Doptimize="${CFLAGS}" \
		-Dscriptdir=/usr/bin \
		-Dprefix='/usr' \
		-Dvendorprefix='/usr' \
		-Dsiteprefix='/usr' \
		-Dprivlib="/usr/$(get_libdir)/perl5/${MY_PV}" \
		-Darchlib="/usr/$(get_libdir)/perl5/${MY_PV}/${myarch}${mythreading}" \
		-Dvendorlib="/usr/$(get_libdir)/perl5/vendor_perl/${MY_PV}" \
		-Dvendorarch="/usr/$(get_libdir)/perl5/vendor_perl/${MY_PV}/${myarch}${mythreading}" \
		-Dsitelib="/usr/$(get_libdir)/perl5/site_perl/${MY_PV}" \
		-Dsitearch="/usr/$(get_libdir)/perl5/site_perl/${MY_PV}/${myarch}${mythreading}" \
		-Dman1dir=/usr/share/man/man1 \
		-Dman3dir=/usr/share/man/man3 \
		-Dinstallman1dir=/usr/share/man/man1 \
		-Dinstallman3dir=/usr/share/man/man3 \
		-Dman1ext='1' \
		-Dman3ext='3pm' \
		-Dlibperl="${LIBPERL}" \
		-Dlocincpth=' ' \
		-Duselargefiles \
		-Dd_semctl_semun \
		-Dinc_version_list="$inclist" \
		-Dcf_by='Gentoo' \
		-Dmyhostname='localhost' \
		-Dperladmin='root@localhost' \
		-Dinstallusrbinperl='n' \
		-Ud_csh \
		-Uusenm \
		"${myconf[@]}" || die "Unable to configure"
}

src_test() {
#	use elibc_uclibc && export MAKEOPTS="${MAKEOPTS} -j1"
#	TEST_JOBS=$(echo -j1 ${MAKEOPTS} | sed -r 's/.*(-j[[:space:]]*|--jobs=)([[:digit:]]+).*/\2/' ) \
		make test_harness || die "test failed"
}

src_install() {
	export LC_ALL="C"
	local i
	local coredir="/usr/$(get_libdir)/perl5/${MY_PV}/${myarch}${mythreading}/CORE"

	# Fix for "stupid" modules and programs
	dodir /usr/$(get_libdir)/perl5/site_perl/${MY_PV}/${myarch}${mythreading}

	local installtarget=install
	if use build ; then
		installtarget=install.perl
	fi
	make DESTDIR="${D}" ${installtarget} || die "Unable to make ${installtarget}"

	rm -f "${D}"/usr/bin/perl
	ln -s perl${MY_PV} "${D}"/usr/bin/perl

	dolib.so "${D}"/${coredir}/${LIBPERL} || die
	dosym ${LIBPERL} /usr/$(get_libdir)/libperl$(get_libname ${SHORT_PV}) || die
	dosym ${LIBPERL} /usr/$(get_libdir)/libperl$(get_libname) || die
	rm -f "${D}"/${coredir}/${LIBPERL}
	dosym ../../../../../$(get_libdir)/${LIBPERL} ${coredir}/${LIBPERL}
	dosym ../../../../../$(get_libdir)/${LIBPERL} ${coredir}/libperl$(get_libname ${SHORT_PV})
	dosym ../../../../../$(get_libdir)/${LIBPERL} ${coredir}/libperl$(get_libname)

	rm -rf "${D}"/usr/share/man/man3 || die "Unable to remove module man pages"
#	cp -f utils/h2ph utils/h2ph_patched
#	epatch "${FILESDIR}"/${PN}-h2ph-ansi-header.patch
#
#	LD_LIBRARY_PATH=. ./perl -Ilib utils/h2ph_patched \
#		-a -d "${D}"/usr/$(get_libdir)/perl5/${MY_PV}/${myarch}${mythreading} <<EOF
#asm/termios.h
#syscall.h
#syslimits.h
#syslog.h
#sys/ioctl.h
#sys/socket.h
#sys/time.h
#wait.h
#EOF

# vvv still needed?
#	# This is to fix a missing c flag for backwards compat
#	for i in $(find "${D}"/usr/$(get_libdir)/perl5 -iname "Config.pm" ) ; do
#		sed -i \
#			-e "s:ccflags=':ccflags='-DPERL5 :" \
#			-e "s:cppflags=':cppflags='-DPERL5 :" \
#			"${i}" || die "Sed failed"
#	done

	# A poor fix for the miniperl issues
	dosed 's:./miniperl:/usr/bin/perl:' /usr/$(get_libdir)/perl5/${MY_PV}/ExtUtils/xsubpp
	fperms 0444 /usr/$(get_libdir)/perl5/${MY_PV}/ExtUtils/xsubpp
	dosed 's:./miniperl:/usr/bin/perl:' /usr/bin/xsubpp
	fperms 0755 /usr/bin/xsubpp

	# This removes ${D} from Config.pm and .packlist
	for i in $(find "${D}" -iname "Config.pm" -o -iname ".packlist" ) ; do
		einfo "Removing ${D} from ${i}..."
		sed -i -e "s:${D}::" "${i}" || die "Sed failed"
	done

	# Note: find out from psm why we would need/want this.
	# ( use berkdb && has_version '=sys-libs/db-1*' ) ||
	#	find "${D}" -name "*NDBM*" | xargs rm -f

	dodoc Changes* README AUTHORS || die

	if use doc ; then
		# HTML Documentation
		# We expect errors, warnings, and such with the following.

		dodir /usr/share/doc/${PF}/html
		./perl installhtml \
			--podroot='.' \
			--podpath='lib:ext:pod:vms' \
			--recurse \
			--htmldir="${D}/usr/share/doc/${PF}/html" \
			--libpods='perlfunc:perlguts:perlvar:perlrun:perlop'
	fi

	dual_scripts

	if use build ; then
		src_remove_extra_files
	fi
}

pkg_postinst() {
	local INC DIR file

	dual_scripts

	INC=$(perl -e 'for $line (@INC) { next if $line eq "."; next if $line =~ m/'${MY_PV}'|etc|local|perl$/; print "$line\n" }')
	if [[ "${ROOT}" = "/" ]] ; then
		ebegin "Removing old .ph files"
		for DIR in ${INC} ; do
			if [[ -d "${ROOT}/${DIR}" ]] ; then
				for file in $(find "${ROOT}/${DIR}" -name "*.ph" -type f ) ; do
					rm -f "${ROOT}/${file}"
					einfo "<< ${file}"
				done
			fi
		done
		# Silently remove the now empty dirs
		for DIR in ${INC} ; do
			if [[ -d "${ROOT}/${DIR}" ]] ; then
				find "${ROOT}/${DIR}" -depth -type d -print0 | xargs -0 -r rmdir &> /dev/null
			fi
		done
		ebegin "Generating ConfigLocal.pm (ignore any error)"
		enc2xs -C
		ebegin "Converting C header files to the corresponding Perl format"
		cd /usr/include
		h2ph -Q *
		h2ph -Q -r sys/* arpa/* netinet/* bits/* security/* asm/* gnu/* linux/*
	fi

# This has been moved into a function because rumor has it that a future release
# of portage will allow us to check what version was just removed - which means
# we will be able to invoke this only as needed :)
	# Tried doing this via  -z, but $INC is too big...
	if [[ "${INC}x" != "x" ]]; then
		cleaner_msg
		epause 5
	fi
}

pkg_postrm(){
	${IS_PERL} && dual_scripts
}

cleaner_msg() {
	eerror "You have had multiple versions of perl. It is recommended"
	eerror "that you run perl-cleaner now. perl-cleaner will"
	eerror "assist with this transition. This script is capable"
	eerror "of cleaning out old .ph files, rebuilding modules for "
	eerror "your new version of perl, as well as re-emerging"
	eerror "applications that compiled against your old libperl$(get_libname)"
	eerror
	eerror "PLEASE DO NOT INTERRUPT THE RUNNING OF THIS SCRIPT."
	eerror "Part of the rebuilding of applications compiled against "
	eerror "your old libperl involves temporarily unmerging"
	eerror "them - interruptions could leave you with unmerged"
	eerror "packages before they can be remerged."
	eerror ""
	eerror "If you have run perl-cleaner and a package still gives"
	eerror "you trouble, and re-emerging it fails to correct"
	eerror "the problem, please check http://bugs.gentoo.org/"
	eerror "for more information or to report a bug."
	eerror ""
}

src_remove_dual_scripts() {
	local i pkg ver ff
	pkg="$1"
	ver="$2"
	shift 2
	if has "${EBUILD_PHASE:-none}" "postinst" "postrm" ;then
		for i in "$@" ; do
			ff=`echo ${ROOT}/usr/share/man/man1/${i}-${ver}-${P}.1*`
			ff=${ff##*.1}
			alternatives_auto_makesym "/usr/bin/${i}" "/usr/bin/${i}-[0-9]*"
			alternatives_auto_makesym "/usr/share/man/man1/${i}.1${ff}" "/usr/share/man/man1/${i}-[0-9]*"
		done
	elif has "${EBUILD_PHASE:-none}" "setup" ; then
		for i in "$@" ; do
			if [[ -f ${ROOT}/usr/bin/${i} && ! -h ${ROOT}/usr/bin/${i} ]] ; then
				has_version ${pkg} && ewarn "You must reinstall $pkg !"
				break
			fi
		done
	else
		for i in "$@" ; do
			mv "${D}"/usr/bin/${i}{,-${ver}-${P}} || die
			mv "${D}"/usr/share/man/man1/${i}{.1,-${ver}-${P}.1} || \
				echo "/usr/share/man/man1/${i}.1 does not exist!"
		done
	fi
}

src_remove_extra_files() {
	local prefix="./usr" # ./ is important
	local bindir="${prefix}/bin"
	local libdir="${prefix}/$(get_libdir)"
	local perlroot="${libdir}/perl5" # perl installs per-arch dirs
	local prV="${perlroot}/${MY_PV}"
	local prVA="${prV}/${myarch}${mythreading}"

	# I made this list from the Mandr*, Debian and ex-Connectiva perl-base list
	# Then, I added several files to get GNU autotools running
	# FIXME: should this be in a separated file to be sourced?
	local MINIMAL_PERL_INSTALL="
	${bindir}/h2ph
	${bindir}/perl
	${bindir}/perl${MY_PV}
	${bindir}/pod2man
	${libdir}/${LIBPERL}
	${libdir}/libperl$(get_libname)
	${libdir}/libperl$(get_libname ${SHORT_PV})
	${prV}/attributes.pm
	${prV}/AutoLoader.pm
	${prV}/autouse.pm
	${prV}/base.pm
	${prV}/bigint.pm
	${prV}/bignum.pm
	${prV}/bigrat.pm
	${prV}/blib.pm
	${prV}/bytes_heavy.pl
	${prV}/bytes.pm
	${prV}/Carp/Heavy.pm
	${prV}/Carp.pm
	${prV}/charnames.pm
	${prV}/Class/Struct.pm
	${prV}/constant.pm
	${prV}/diagnostics.pm
	${prV}/DirHandle.pm
	${prV}/Exporter/Heavy.pm
	${prV}/Exporter.pm
	${prV}/ExtUtils/Command.pm
	${prV}/ExtUtils/Constant.pm
	${prV}/ExtUtils/Embed.pm
	${prV}/ExtUtils/Installed.pm
	${prV}/ExtUtils/Install.pm
	${prV}/ExtUtils/Liblist.pm
	${prV}/ExtUtils/MakeMaker.pm
	${prV}/ExtUtils/Manifest.pm
	${prV}/ExtUtils/Mkbootstrap.pm
	${prV}/ExtUtils/Mksymlists.pm
	${prV}/ExtUtils/MM_Any.pm
	${prV}/ExtUtils/MM_MacOS.pm
	${prV}/ExtUtils/MM.pm
	${prV}/ExtUtils/MM_Unix.pm
	${prV}/ExtUtils/MY.pm
	${prV}/ExtUtils/Packlist.pm
	${prV}/ExtUtils/testlib.pm
	${prV}/ExtUtils/Miniperl.pm
	${prV}/ExtUtils/Command/MM.pm
	${prV}/ExtUtils/Constant/Base.pm
	${prV}/ExtUtils/Constant/Utils.pm
	${prV}/ExtUtils/Constant/XS.pm
	${prV}/ExtUtils/Liblist/Kid.pm
	${prV}/ExtUtils/MakeMaker/bytes.pm
	${prV}/ExtUtils/MakeMaker/vmsish.pm
	${prV}/fields.pm
	${prV}/File/Basename.pm
	${prV}/File/Compare.pm
	${prV}/File/Copy.pm
	${prV}/File/Find.pm
	${prV}/FileHandle.pm
	${prV}/File/Path.pm
	${prV}/File/Spec.pm
	${prV}/File/Spec/Unix.pm
	${prV}/File/stat.pm
	${prV}/filetest.pm
	${prVA}/attrs.pm
	${prVA}/auto/attrs
	${prVA}/auto/Cwd/Cwd$(get_libname)
	${prVA}/auto/Data/Dumper/Dumper$(get_libname)
	${prVA}/auto/DynaLoader/dl_findfile.al
	${prVA}/auto/Fcntl/Fcntl$(get_libname)
	${prVA}/auto/File/Glob/Glob$(get_libname)
	${prVA}/auto/IO/IO$(get_libname)
	${prVA}/auto/POSIX/autosplit.ix
	${prVA}/auto/POSIX/fstat.al
	${prVA}/auto/POSIX/load_imports.al
	${prVA}/auto/POSIX/POSIX.bs
	${prVA}/auto/POSIX/POSIX$(get_libname)
	${prVA}/auto/POSIX/stat.al
	${prVA}/auto/POSIX/tmpfile.al
	${prVA}/auto/re/re$(get_libname)
	${prVA}/auto/Socket/Socket$(get_libname)
	${prVA}/auto/Storable/autosplit.ix
	${prVA}/auto/Storable/_retrieve.al
	${prVA}/auto/Storable/retrieve.al
	${prVA}/auto/Storable/Storable$(get_libname)
	${prVA}/auto/Storable/_store.al
	${prVA}/auto/Storable/store.al
	${prVA}/B/Deparse.pm
	${prVA}/B.pm
	${prVA}/Config.pm
	${prVA}/Config_heavy.pl
	${prVA}/CORE/libperl$(get_libname)
	${prVA}/Cwd.pm
	${prVA}/Data/Dumper.pm
	${prVA}/DynaLoader.pm
	${prVA}/encoding.pm
	${prVA}/Errno.pm
	${prVA}/Fcntl.pm
	${prVA}/File/Glob.pm
	${prVA}/_h2ph_pre.ph
	${prVA}/IO/File.pm
	${prVA}/IO/Handle.pm
	${prVA}/IO/Pipe.pm
	${prVA}/IO.pm
	${prVA}/IO/Seekable.pm
	${prVA}/IO/Select.pm
	${prVA}/IO/Socket.pm
	${prVA}/lib.pm
	${prVA}/NDBM_File.pm
	${prVA}/ops.pm
	${prVA}/POSIX.pm
	${prVA}/re.pm
	${prVA}/Socket.pm
	${prVA}/Storable.pm
	${prVA}/threads
	${prVA}/threads.pm
	${prVA}/XSLoader.pm
	${prV}/Getopt/Long.pm
	${prV}/Getopt/Std.pm
	${prV}/if.pm
	${prV}/integer.pm
	${prV}/IO/Socket/INET.pm
	${prV}/IO/Socket/UNIX.pm
	${prV}/IPC/Open2.pm
	${prV}/IPC/Open3.pm
	${prV}/less.pm
	${prV}/List/Util.pm
	${prV}/locale.pm
	${prV}/open.pm
	${prV}/overload.pm
	${prV}/Pod/InputObjects.pm
	${prV}/Pod/Man.pm
	${prV}/Pod/ParseLink.pm
	${prV}/Pod/Parser.pm
	${prV}/Pod/Select.pm
	${prV}/Pod/Text.pm
	${prV}/Pod/Usage.pm
	${prV}/PerlIO.pm
	${prV}/Scalar/Util.pm
	${prV}/SelectSaver.pm
	${prV}/sigtrap.pm
	${prV}/sort.pm
	${prV}/stat.pl
	${prV}/strict.pm
	${prV}/subs.pm
	${prV}/Symbol.pm
	${prV}/Text/ParseWords.pm
	${prV}/Text/Tabs.pm
	${prV}/Text/Wrap.pm
	${prV}/Time/Local.pm
	${prV}/unicore/Canonical.pl
	${prV}/unicore/Exact.pl
	${prV}/unicore/lib/gc_sc/Digit.pl
	${prV}/unicore/lib/gc_sc/Word.pl
	${prV}/unicore/PVA.pl
	${prV}/unicore/To/Fold.pl
	${prV}/unicore/To/Lower.pl
	${prV}/unicore/To/Upper.pl
	${prV}/utf8_heavy.pl
	${prV}/utf8.pm
	${prV}/vars.pm
	${prV}/vmsish.pm
	${prV}/warnings
	${prV}/warnings.pm
	${prV}/warnings/register.pm"

	pushd "${D}" > /dev/null
	# Remove cruft
	einfo "Removing files that are not in the minimal install"
	echo "${MINIMAL_PERL_INSTALL}"
	for f in $(find . -type f ) ; do
		has "${f}" ${MINIMAL_PERL_INSTALL} || rm -f "${f}"
	done
	# Remove empty directories
	find . -depth -type d -print0 | xargs -0 -r rmdir &> /dev/null
	popd > /dev/null
}
