# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/urxvt-font-size/urxvt-font-size-99999999.ebuild,v 1.1 2014/05/02 05:00:30 radhermit Exp $

EAPI=5
inherit multilib

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://github.com/majutsushi/urxvt-font-size.git"
	inherit git-r3
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://dev.gentoo.org/~radhermit/dist/${P}.tar.gz"
fi

DESCRIPTION="Perl extension for rxvt-unicode to change the font size on the fly"
HOMEPAGE="https://github.com/majutsushi/urxvt-font-size/"

LICENSE="MIT"
SLOT="0"

RDEPEND="x11-terms/rxvt-unicode[perl]"

src_install() {
	insinto /usr/$(get_libdir)/urxvt/perl
	doins font-size
	dodoc README.markdown
}
