# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellflynn/gkrellflynn-0.8.ebuild,v 1.9 2008/11/18 14:06:53 lack Exp $

inherit gkrellm-plugin

IUSE=""
HOMEPAGE="http://bax.comlab.uni-rostock.de/en/projects/flynn.html"
SRC_URI="http://bax.comlab.uni-rostock.de/fileadmin/downloads/${P}.tar.gz"
DESCRIPTION="A funny GKrellM2 load monitor (for Doom(tm) fans)"
KEYWORDS="alpha amd64 ppc sparc x86"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	make gkrellm2
}
