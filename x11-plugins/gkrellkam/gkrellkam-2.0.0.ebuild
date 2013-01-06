# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellkam/gkrellkam-2.0.0.ebuild,v 1.13 2007/03/09 16:01:53 lack Exp $

inherit gkrellm-plugin

MY_P=${P/-/_}
IUSE=""
DESCRIPTION="an Image-Watcher-Plugin for GKrellM2."
SRC_URI="mirror://sourceforge/gkrellkam/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellkam.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"

RDEPEND="net-misc/wget"

PLUGIN_SO=gkrellkam2.so
PLUGIN_DOCS="example.list"

src_install () {
	gkrellm-plugin_src_install
	doman gkrellkam-list.5
}
