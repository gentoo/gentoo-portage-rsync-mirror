# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/markdown-mode/markdown-mode-1.8.1.ebuild,v 1.5 2011/12/26 14:17:33 ulm Exp $

EAPI=4

inherit elisp

DESCRIPTION="Major mode for editing Markdown-formatted text files"
HOMEPAGE="http://jblevins.org/projects/markdown-mode/"
# Cannot use this url because its hash differ about every five minutes
# SRC_URI="http://jblevins.org/git/markdown-mode.git/snapshot/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.el.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/xz-utils"

SITEFILE="50${PN}-gentoo.el"
