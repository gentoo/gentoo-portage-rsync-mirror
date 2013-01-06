# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-2.2.2-r1.ebuild,v 1.2 2012/07/09 21:29:15 ulm Exp $

inherit eutils

S="${WORKDIR}/fpcbuild-${PV}/fpcsrc"

HOMEPAGE="http://www.freepascal.org/"
DESCRIPTION="Free Pascal Compiler"
SRC_URI="mirror://sourceforge/freepascal/fpcbuild-${PV}.tar.gz
	x86? ( mirror://sourceforge/freepascal/fpc-2.2.2.i386-linux.tar )
	sparc? ( mirror://sourceforge/freepascal/fpc-2.0.0.sparc-linux.tar )
	ppc? ( mirror://sourceforge/freepascal/fpc-2.2.0.powerpc-linux.tar )
	amd64? ( mirror://sourceforge/freepascal/fpc-2.2.2.x86_64-linux.tar )
	doc? ( mirror://sourceforge/freepascal/fpc-${PV}-doc-pdf.zip )"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1-with-linking-exception"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc source"

DEPEND="!dev-lang/fpc-bin
	!dev-lang/fpc-source"
RDEPEND="${DEPEND}"
DEPEND="${DEPEND}
	>=sys-devel/binutils-2.19.1-r1"

src_unpack() {
	case ${ARCH} in
	x86)	FPC_ARCH="i386"    PV_BIN=2.2.2 ;;
	ppc)	FPC_ARCH="powerpc" PV_BIN=2.2.0 ;;
	amd64)	FPC_ARCH="x86_64"  PV_BIN=2.2.2 ;;
	sparc)	FPC_ARCH="sparc"   PV_BIN=2.0.0 ;;
	*)	die "This ebuild doesn't support ${ARCH}." ;;
	esac

	unpack ${A} || die "Unpacking ${A} failed!"

	tar -xf binary.${FPC_ARCH}-linux.tar || die "Unpacking binary.${FPC_ARCH}-linux.tar failed!"
	tar -xzf base.${FPC_ARCH}-linux.tar.gz || die "Unpacking base.${FPC_ARCH}-linux.tar.gz failed!"

	cd "${S}"
	epatch "${FILESDIR}"/${P}-unneeded-symbols.patch
	epatch "${FILESDIR}"/${P}-execstack.patch
	sed -i -e 's/ -Xs / /g' $(find . -name Makefile) || die "sed failed"
}

set_pp() {
	case ${ARCH} in
	x86)	FPC_ARCH="386" ;;
	ppc)	FPC_ARCH="ppc" ;;
	amd64)	FPC_ARCH="x64" ;;
	sparc)	FPC_ARCH="sparc" ;;
	*)	die "This ebuild doesn't support ${ARCH}." ;;
	esac

	case ${1} in
	bootstrap)	pp="${WORKDIR}"/lib/fpc/${PV_BIN}/ppc${FPC_ARCH} ;;
	new) 	pp="${S}"/compiler/ppc${FPC_ARCH} ;;
	*)	die "set_pp: unknown argument: ${1}" ;;
	esac
}

src_compile() {
	local pp

	# Using the bootstrap compiler.
	set_pp bootstrap

	emake -j1 PP="${pp}" compiler_cycle || die "make compiler_cycle failed!"

	# Save new compiler from cleaning...
	cp "${S}"/compiler/ppc${FPC_ARCH} "${S}"/ppc${FPC_ARCH}.new

	# ...rebuild with current version...
	emake -j1 PP="${S}"/ppc${FPC_ARCH}.new compiler_cycle || die "make compiler_cycle failed!"

	# ..and clean up afterwards
	rm "${S}"/ppc${FPC_ARCH}.new

	# Using the new compiler.
	set_pp new

	emake -j1 PP="${pp}" rtl_clean || die "make rtl_clean failed"

	emake -j1 PP="${pp}" rtl packages_all utils || die "make failed"

	# Use pregenerated docs to avoid sandbox violations (#146804)
	#if use doc ; then
	#	cd "${S}"/../fpcdocs
	#	emake -j1 pdf || die "make pdf failed!"
	#fi
}

src_install() {
	local pp
	set_pp new

	set -- PP="${pp}" FPCMAKE="${S}/utils/fpcm/fpcmake" \
		INSTALL_PREFIX="${D}"usr \
		INSTALL_DOCDIR="${D}"usr/share/doc/${P} \
		INSTALL_MANDIR="${D}"usr/share/man \
		INSTALL_SOURCEDIR="${D}"usr/lib/fpc/${PV}/source

	emake -j1 "$@" compiler_install rtl_install packages_install \
		utils_install || die "make install failed!"

	dosym ../lib/fpc/${PV}/ppc${FPC_ARCH} /usr/bin/ppc${FPC_ARCH}

	if ! has nodoc ${FEATURES} ; then
		cd "${S}"/../install/doc
		emake -j1 "$@" installdoc || die "make installdoc failed!"
	fi

	if ! has noman ${FEATURES} ; then
		cd "${S}"/../install/man
		emake -j1 "$@" installman || die "make installman failed!"
	fi

	if ! has nodoc ${FEATURES} && use doc ; then
		insinto /usr/share/doc/${PF}
		doins "${WORKDIR}"/doc/*.pdf
		#cd "${S}"/../fpcdocs
		#emake -j1 "$@" pdfinstall || die "make pdfinstall failed"
	fi

	if use source ; then
		cd "${S}"
		shift
		emake -j1 PP="${D}"usr/bin/ppc${FPC_ARCH} "$@" sourceinstall || die "make sourceinstall failed!"
		find "${D}"usr/lib/fpc/${PV}/source -name '*.o' -exec rm {} \;
	fi

	"${D}"usr/lib/fpc/${PV}/samplecfg /usr/lib/fpc/${PV} "${D}"etc

	rm -rf "${D}"usr/lib/fpc/lexyacc
}

pkg_postinst() {
	# Using ewarn - it is really important for other ebuilds (e.g. Lazarus)
	if [ -e /etc/._cfg0000_fpc.cfg ]; then
		echo
		ewarn "Make sure you etc-update /etc/fpc.cfg"
		ewarn "Otherwise FPC will not work correctly."
		echo
		ebeep
	fi

	ewarn "The default configuration for fpc strips executables. This"
	ewarn "will cause QA notices in ebuilds for software using fpc."
	ewarn "You can remove -Xs from /etc/fpc.cfg to avoid this."
}
