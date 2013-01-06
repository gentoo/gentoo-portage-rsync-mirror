# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/graphviz-dot-mode/graphviz-dot-mode-0.3.4.ebuild,v 1.4 2011/04/22 16:18:47 ulm Exp $

inherit elisp

DESCRIPTION="Emacs mode for editing and previewing Graphviz dot graphs"
HOMEPAGE="http://users.skynet.be/ppareit/projects/graphviz-dot-mode/graphviz-dot-mode.html
	http://www.graphviz.org/"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE="50${PN}-gentoo-${PV}.el"
