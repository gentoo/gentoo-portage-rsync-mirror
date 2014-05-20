# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ekopath/ekopath-5.0.1_pre20131115.ebuild,v 1.1 2014/05/20 22:40:56 bicatali Exp $

EAPI=5

inherit versionator

MY_PV=$(get_version_component_range 1-3)
DATE=$(get_version_component_range 4)
DATE=${DATE/pre}
DATE=${DATE:0:4}-${DATE:4:2}-${DATE:6}

DESCRIPTION="PathScale EKOPath Compiler Suite"
HOMEPAGE="http://www.pathscale.com/ekopath-compiler-suite"
SRC_URI="http://c591116.r16.cf2.rackcdn.com/${PN}/nightly/Linux/${PN}-${DATE}-installer.run
	-> ${P}.run"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux"
IUSE=""

DEPEND="!!app-arch/rpm"
RDEPEND=""

RESTRICT="mirror"

S="${WORKDIR}"

QA_PREBUILT="
	opt/${PN}/lib/${MY_PV}/x8664/*
	opt/${PN}/bin/path*
	opt/${PN}/bin/funclookup
	opt/${PN}/bin/doctool
	opt/${PN}/bin/subclient
	opt/${PN}/bin/subserver
	opt/${PN}/bin/assign"

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}" || die
	chmod +x "${S}"/${P}.run
}

src_prepare() {
	cat > "99${PN}" <<-EOF
		PATH=${EROOT%/}/opt/${PN}/bin
		ROOTPATH=${EROOT%/}/opt/${PN}/bin
		LDPATH=${EROOT%/}/opt/${PN}/lib:${EROOT%/}/opt/${PN}/lib/${MY_PV}/x8664/64
		MANPATH=${EROOT%/}/opt/${PN}/docs/man
	EOF
}

src_install() {
	local opts
	# You must paxmark -m EI_PAX (not PT_PAX) to run the installer
	# on a pax enabled kernel.  Adding PT_PAX breaks the binary.
	scanelf -Xxz m ${P}.run >> /dev/null

	./${P}.run \
		--prefix "${ED}/opt/${PN}" \
		--mode unattended \
		${opts} || die

	# This is a temporary/partial fix to remove a RWX GNU STACK header
	# from libstl.so.  It still leaves libstl.a in bad shape.
	# The correct fix is in the assembly atomic-cxx.S, which we don't get
	#   See http://www.gentoo.org/proj/en/hardened/gnu-stack.xml
	#   Section 6.  How to fix the stack (in practice)
	scanelf -Xe "${ED}/opt/ekopath/lib/${MY_PV}/x8664/64/libstl.so"

	rm -r "${ED}"/opt/${PN}/uninstall || die
	doenvd "99${PN}"
}
