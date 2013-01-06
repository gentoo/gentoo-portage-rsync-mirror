# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmss/gkrellmss-2.6.ebuild,v 1.14 2012/03/18 12:40:32 ssuominen Exp $

EAPI=1
inherit gkrellm-plugin

IUSE="nls"

DESCRIPTION="A plugin for GKrellM2 that has a VU meter and a sound chart"
HOMEPAGE="http://members.dslextreme.com/users/billw/gkrellmss/gkrellmss.html"
SRC_URI="http://web.wt.net/~billw/gkrellmss/${P}.tar.gz"

RDEPEND="=sci-libs/fftw-2*
	media-libs/alsa-lib"

DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc sparc x86"

PLUGIN_SO="src/gkrellmss.so"
PLUGIN_DOCS="Themes"

src_compile() {
	local myconf

	use nls && myconf="${myconf} enable_nls=1"

	addpredict /dev/snd
	emake ${myconf} || die
}
