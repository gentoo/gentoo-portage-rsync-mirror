# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ekopath/ekopath-4.0.12.1_pre20120308.ebuild,v 1.1 2012/03/08 12:28:14 xarthisius Exp $

EAPI=4

inherit versionator

MY_PV=$(get_version_component_range 1-4)
DATE=$(get_version_component_range 5)
DATE=${DATE/pre}
DATE=${DATE:0:4}-${DATE:4:2}-${DATE:6}

DESCRIPTION="PathScale EKOPath Compiler Suite"
HOMEPAGE="http://www.pathscale.com/ekopath-compiler-suite"
SRC_URI="http://c591116.r16.cf2.rackcdn.com/${PN}/nightly/Linux/${PN}-${DATE}-installer.run
	-> ${P}.run"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

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

pkg_pretend() {
	if has_version app-arch/rpm ; then
		ewarn "You have app-arch/rpm installed on your system. Therefore"
		ewarn "${PN} will fail to install due to sandbox violation."
		ewarn "As this cannot be fixed on distribution level, please use"
		ewarn "following workaround:"
		ewarn "  emerge -C rpm && emerge -1 ${PN} && emerge -1 rpm"
		die
	fi
}

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
	# You must paxmark -m EI_PAX (not PT_PAX) to run the installer
	# on a pax enabled kernel.  Adding PT_PAX breaks the binary.
	/usr/bin/scanelf -Xxz m ${P}.run >> /dev/null

	./${P}.run \
		--prefix "${D}/opt/${PN}" \
		--disable-components subscriptionmanager \
		--mode unattended || die

	# This is a temporary/partial fix to remove a RWX GNU STACK header
	# from libstl.so.  It still leaves libstl.a in bad shape.
	# The correct fix is in the assembly atomic-cxx.S, which we don't get
	#   See http://www.gentoo.org/proj/en/hardened/gnu-stack.xml
	#   Section 6.  How to fix the stack (in practice)
	/usr/bin/scanelf -Xe "${D}/opt/ekopath/lib/4.0.11/x8664/64/libstl.so"

	rm -rf "${D}"/opt/${PN}/uninstall || die
	rm -rf "${D}"/opt/${PN}/bin/{pathdb,funclookup} || die #libtinfo
	rm -rf "${D}"/opt/${PN}/lib/${MY_PV}/x8664/coco || die #DT_PATH
	doenvd "99${PN}"
}
