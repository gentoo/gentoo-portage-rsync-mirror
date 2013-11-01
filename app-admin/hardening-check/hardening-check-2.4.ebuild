# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hardening-check/hardening-check-2.4.ebuild,v 1.3 2013/11/01 13:35:47 ago Exp $

EAPI="5"

MY_PN="hardening-wrapper"

DESCRIPTION="Report the hardening characterists of a set of binaries"
HOMEPAGE="https://wiki.debian.org/Hardening"
SRC_URI="mirror://debian/pool/main/h/${MY_PN}/${MY_PN}_${PV}.tar.gz"

KEYWORDS="amd64 x86"
IUSE=""
LICENSE="GPL-2+"
SLOT="0"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	# This is what the Makefile does to detect FORTIFY_SOURCE
	perl -pi -e "s/^my %libc;/my %libc = (\n$(perl hardening-check --find-libc-functions /bin/ls)\n);/;" ${PN} || die
}

src_compile() { :; }

src_install() {
	dobin ${PN}
}
