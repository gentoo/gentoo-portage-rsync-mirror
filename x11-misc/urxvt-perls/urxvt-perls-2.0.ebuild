# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/urxvt-perls/urxvt-perls-2.0.ebuild,v 1.4 2013/09/10 13:14:28 xmw Exp $

EAPI=4

inherit multilib

DESCRIPTION="Perl extensions for rxvt-unicode"
HOMEPAGE="https://github.com/muennich/urxvt-perls"
SRC_URI="mirror://github/muennich/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="x11-misc/xsel
	x11-terms/rxvt-unicode[perl]"

src_install() {
	insinto /usr/$(get_libdir)/urxvt/perl
	doins clipboard keyboard-select url-select
	dodoc README.md
}
