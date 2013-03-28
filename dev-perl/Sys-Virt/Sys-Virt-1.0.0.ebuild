# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Virt/Sys-Virt-1.0.0.ebuild,v 1.2 2013/03/28 07:54:50 pinkbyte Exp $

EAPI=4

MODULE_AUTHOR=DANBERR
MODULE_VERSION=1.0.0
inherit perl-module

DESCRIPTION="Sys::Virt provides an API for using the libvirt library from Perl"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="test"

RDEPEND=">=app-emulation/libvirt-${PV}"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/XML-XPath
		virtual/perl-Time-HiRes
	)"

SRC_TEST="do"

src_compile() {
	MAKEOPTS+=" -j1" perl-module_src_compile
}
