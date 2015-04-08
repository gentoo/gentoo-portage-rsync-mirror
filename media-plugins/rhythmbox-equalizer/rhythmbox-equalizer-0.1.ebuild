# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/rhythmbox-equalizer/rhythmbox-equalizer-0.1.ebuild,v 1.3 2012/10/25 20:33:24 eva Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"

inherit eutils multilib python

MY_P="rb-equalizer-${PV}"

DESCRIPTION="10-band graphic equalizer plugin for Rhythmbox"
HOMEPAGE="http://www.lirmm.fr/~morandat/index.php/Main/Tools"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	x11-libs/gtk+:2
	>=dev-python/pygtk-2.8:2
	gnome-base/libglade:2.0
	>=media-libs/gst-plugins-base-0.10.29:0.10
	>=media-sound/rhythmbox-0.12.8[python]"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	insinto /usr/$(get_libdir)/rhythmbox/plugins
	doins -r equalizer || die
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/rhythmbox/plugins/equalizer
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/rhythmbox/plugins/equalizer
}
