# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ferm/ferm-2.1.1.ebuild,v 1.5 2012/10/17 03:15:02 phajdan.jr Exp $

EAPI=4

inherit versionator

MY_PV="$(get_version_component_range 1-2)"
DESCRIPTION="Command line util for managing firewall rules"
HOMEPAGE="http://ferm.foo-projects.org/"
SRC_URI="http://ferm.foo-projects.org/download/${MY_PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-lang/perl
	net-firewall/iptables
	virtual/perl-File-Spec"

src_prepare() {
	sed -e "s/COPYING//" -i Makefile || die
}

src_compile() { :; }

src_install () {
	emake PREFIX="${D}/usr" DOCDIR="${D}/usr/share/doc/${PF}" install
}

pkg_postinst() {
	einfo "See /usr/share/doc/${PF}/examples for sample configs"
}
