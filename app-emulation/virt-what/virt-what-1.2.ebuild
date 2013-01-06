# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-what/virt-what-1.2.ebuild,v 1.2 2010/07/16 22:01:56 cardoe Exp $

EAPI=3

inherit eutils autotools

DESCRIPTION="Detects if the current machine is running in a virtual machine"
HOMEPAGE="http://people.redhat.com/~rjones/virt-what/"
SRC_URI="http://people.redhat.com/~rjones/virt-what/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="app-shells/bash
		sys-apps/dmidecode"

src_prepare() {
	epatch "${FILESDIR}"/${P}-bin-to-sbin.patch
	epatch "${FILESDIR}"/${P}-vmware-cpuid-check.patch

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
