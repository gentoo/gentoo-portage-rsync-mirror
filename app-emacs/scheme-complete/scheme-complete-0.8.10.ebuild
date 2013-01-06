# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/scheme-complete/scheme-complete-0.8.10.ebuild,v 1.1 2012/03/19 18:01:25 ulm Exp $

EAPI=4

inherit elisp

DESCRIPTION="Scheme tab-completion and word-completion for Emacs"
HOMEPAGE="http://synthcode.com/"
SRC_URI="http://synthcode.com/emacs/${P}.el.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

SITEFILE="60${PN}-gentoo.el"
