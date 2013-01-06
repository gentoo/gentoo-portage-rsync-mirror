# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/edit-list/edit-list-0.3.ebuild,v 1.2 2008/06/19 17:43:06 ulm Exp $

inherit elisp

DESCRIPTION="Edit a single list"
HOMEPAGE="http://mwolson.org/projects/"
# taken from http://mwolson.org/static/dist/elisp/edit-list.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
