# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/csharp-mode/csharp-mode-0.7.0-r1.ebuild,v 1.2 2009/09/22 11:22:49 maekke Exp $

NEED_EMACS=22

inherit elisp

DESCRIPTION="A derived Emacs mode implementing most of the C# rules"
HOMEPAGE="http://mfgames.com/csharp-mode/start"
SRC_URI="http://mfgames.com/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
