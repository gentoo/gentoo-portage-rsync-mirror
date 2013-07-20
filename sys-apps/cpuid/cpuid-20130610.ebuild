# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpuid/cpuid-20130610.ebuild,v 1.1 2013/07/20 17:11:07 hwoarang Exp $

EAPI="5"

inherit eutils toolchain-funcs

DESCRIPTION="Utility to get detailed information about the CPU(s) using the
CPUID instruction"
HOMEPAGE="http://www.etallen.com/cpuid.html"
SRC_URI="http://www.etallen.com/${PN}/${P}.src.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-20110305-Makefile.patch
	epatch "${FILESDIR}"/${PN}-20110305-fPIC.patch #376245
}

src_compile() {
	tc-export CC
	emake
}

src_install() {
	emake BUILDROOT="${D}" install
}
