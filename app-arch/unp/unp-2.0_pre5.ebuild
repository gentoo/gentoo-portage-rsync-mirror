# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unp/unp-2.0_pre5.ebuild,v 1.1 2010/10/21 19:55:35 hanno Exp $

EAPI=2

inherit eutils bash-completion

DESCRIPTION="Script for unpacking various file formats"
HOMEPAGE="http://packages.qa.debian.org/u/unp.html"
SRC_URI="mirror://debian/pool/main/u/unp/${PN}_${PV/_/~}.tar.gz"
S="${WORKDIR}/${PN}-${PV/_/~}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

RDEPEND="${DEPEND}
	dev-lang/perl"

src_compile() {
	if use nls; then
		cd po
		emake
	fi
}

src_install() {
	dobin unp || die "dobin failed"
	dosym /usr/bin/unp /usr/bin/ucat
	doman debian/unp.1 || die "doman failed"
	dodoc debian/changelog debian/README.Debian
	dobashcompletion bash_completion.d/unp

	if use nls; then
		cd po
		emake DESTDIR="${D}" install
	fi
}
