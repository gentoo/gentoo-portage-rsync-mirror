# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rpm-spec-mode/rpm-spec-mode-0.12.ebuild,v 1.3 2013/06/04 21:12:01 bicatali Exp $

inherit elisp

DESCRIPTION="Emacs mode to ease editing of RPM spec files"
HOMEPAGE="http://www.emacswiki.org/emacs/RpmSpecMode"
SRC_URI="mirror://gentoo/${P}.el"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
		cp "${DISTDIR}"/${P}.el "${WORKDIR}"/${PN}.el
}
