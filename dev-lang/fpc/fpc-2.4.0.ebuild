# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-2.4.0.ebuild,v 1.6 2012/07/09 21:29:15 ulm Exp $

EAPI=2

inherit eutils

RESTRICT="strip" #269221

S="${WORKDIR}/fpcbuild-${PV}/fpcsrc"

HOMEPAGE="http://www.freepascal.org/"
DESCRIPTION="Free Pascal Compiler"
SRC_URI="mirror://sourceforge/freepascal/fpcbuild-${PV}.tar.gz
	amd64? ( mirror://sourceforge/freepascal/fpc-2.4.0.x86_64-linux.tar )
	ppc? ( mirror://sourceforge/freepascal/fpc-2.4.0.powerpc-linux.tar )
	sparc? ( mirror://sourceforge/freepascal/fpc-2.2.4.sparc-linux.tar )
	x86? ( mirror://sourceforge/freepascal/fpc-2.4.0.i386-linux.tar )
	doc? ( mirror://sourceforge/freepascal/Documentation/${PV}/doc-html.tar.gz -> fpc-${PV}-doc-html.tar.gz
		mirror://gentoo/fpc-${PV}-fpctoc.htx.bz2 )"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1-with-linking-exception"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc source"

DEPEND="!dev-lang/fpc-bin
	!dev-lang/fpc-source"
RDEPEND="${DEPEND}"
#DEPEND="${DEPEND}
#	>=sys-devel/binutils-2.19.1-r1"

src_unpack() {
	case ${ARCH} in
	amd64)	FPC_ARCH="x86_64"  PV_BIN=2.4.0 ;;
	ppc)	FPC_ARCH="powerpc" PV_BIN=2.4.0 ;;
	sparc)	FPC_ARCH="sparc"   PV_BIN=2.2.4 ;;
	x86)	FPC_ARCH="i386"    PV_BIN=2.4.0 ;;
	*)	die "This ebuild doesn't support ${ARCH}." ;;
	esac

	unpack ${A} || die "Unpacking ${A} failed!"

	tar -xf binary.${FPC_ARCH}-linux.tar || die "Unpacking binary.${FPC_ARCH}-linux.tar failed!"
	tar -xzf base.${FPC_ARCH}-linux.tar.gz || die "Unpacking base.${FPC_ARCH}-linux.tar.gz failed!"

	#cd "${S}"
	#sed -i -e 's/ -Xs / /g' $(find . -name Makefile) || die "sed failed"
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

	cd "${S}"/../install/doc
	emake -j1 "$@" installdoc || die "make installdoc failed!"

	cd "${S}"/../install/man
	emake -j1 "$@" installman || die "make installman failed!"

	if use doc ; then
		cd "${S}"/../../doc || die
		insinto /usr/share/doc/${P}
		doins -r * || die "doins fpdocs failed"
		newins "${WORKDIR}"/fpc-${PV}-fpctoc.htx fpctoc.htx || die "newins fpctoc.htx failed"
	fi

	if use source ; then
		cd "${S}"
		shift
		emake -j1 PP="${D}"usr/bin/ppc${FPC_ARCH} "$@" sourceinstall || die "make sourceinstall failed!"
		find "${D}"usr/lib/fpc/${PV}/source -name '*.o' -exec rm {} \;
	fi

	"${D}"usr/lib/fpc/${PV}/samplecfg "${D}"usr/lib/fpc/${PV} "${D}"etc || die "samplecfg failed"
	sed -i -e "s:${D}:/:g" "${D}"etc/fpc.cfg || die "sed fpc.cfg failed"

	rm -rf "${D}"usr/lib/fpc/lexyacc
}
