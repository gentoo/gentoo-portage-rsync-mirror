# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/inform-mode/inform-mode-1.5.8.ebuild,v 1.15 2007/12/14 20:21:00 ulm Exp $

inherit elisp

DESCRIPTION="A major mode for editing Inform programs"
HOMEPAGE="http://web.archive.org/web/20061205053408/http://rupert-lane.org/inform-mode/
	http://www.emacswiki.org/cgi-bin/emacs-en/InformMode"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

S="${WORKDIR}/${PN}"

SITEFILE=50${PN}-gentoo.el
