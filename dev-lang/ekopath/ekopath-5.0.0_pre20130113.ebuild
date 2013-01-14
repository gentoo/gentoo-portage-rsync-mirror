# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ekopath/ekopath-5.0.0_pre20130113.ebuild,v 1.1 2013/01/14 17:41:37 xarthisius Exp $

EAPI=4

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
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="!!app-arch/rpm"
RDEPEND=""

RESTRICT="mirror"

S=${WORKDIR}

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
		PATH=/opt/${PN}/bin
		ROOTPATH=/opt/${PN}/bin
		LDPATH=/opt/${PN}/lib:/opt/${PN}/lib/${MY_PV}/x8664/64
	EOF
}

src_install() {
	local opts
	use doc || opts="${opts} --disable-components documentation"
	# You must paxmark -m EI_PAX (not PT_PAX) to run the installer
	# on a pax enabled kernel.  Adding PT_PAX breaks the binary.
	/usr/bin/scanelf -Xxz m ${P}.run >> /dev/null

	./${P}.run \
		--prefix "${D}/opt/${PN}" \
		--mode unattended \
		${opts} || die

	# This is a temporary/partial fix to remove a RWX GNU STACK header
	# from libstl.so.  It still leaves libstl.a in bad shape.
	# The correct fix is in the assembly atomic-cxx.S, which we don't get
	#   See http://www.gentoo.org/proj/en/hardened/gnu-stack.xml
	#   Section 6.  How to fix the stack (in practice)
	/usr/bin/scanelf -Xe "${D}/opt/ekopath/lib/${MY_PV}/x8664/64/libstl.so"

	rm -rf "${D}"/opt/${PN}/uninstall || die
	rm -rf "${D}"/opt/${PN}/bin/{pathdb,funclookup} || die #libtinfo
	rm -rf "${D}"/opt/${PN}/lib/${MY_PV}/x8664/coco || die #DT_PATH
	doenvd "99${PN}"
}
