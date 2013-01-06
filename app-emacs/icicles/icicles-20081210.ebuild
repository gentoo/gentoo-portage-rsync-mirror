# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/icicles/icicles-20081210.ebuild,v 1.2 2009/03/29 22:30:30 ulm Exp $

inherit elisp

DESCRIPTION="Minibuffer input completion and cycling"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/Icicles"
# snapshot from http://www.emacswiki.org/cgi-bin/wiki/Icicles_-_Libraries
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}"
ELISP_PATCHES="${PN}-byte-compile-without-x.patch"
SITEFILE="50${PN}-gentoo.el"
