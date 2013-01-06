# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/scheme-complete/scheme-complete-0.8.9.ebuild,v 1.3 2010/06/01 13:12:48 josejx Exp $

inherit elisp

DESCRIPTION="Scheme tab-completion and word-completion for Emacs"
HOMEPAGE="http://synthcode.com/emacs/"
SRC_URI="http://synthcode.com/emacs/${P}.el.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

SITEFILE="60${PN}-gentoo.el"
