# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pithos/pithos-99999999.ebuild,v 1.1 2013/07/11 17:06:04 chutzpah Exp $

EAPI=5
PYTHON_COMPAT=(python2_7)
inherit eutils distutils-r1

if [[ ${PV} == 99999999 ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/kevinmehall/pithos.git
					https://github.com/kevinmehall/pithos.git"
else
	MY_PV=""
	SRC_URI="https://github.com/kevinmehall/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

DESCRIPTION="A Pandora Radio (pandora.com) player for the GNOME Desktop"
HOMEPAGE="http://kevinmehall.net/p/pithos/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="gnome"

DEPEND="dev-python/setuptools"

RDEPEND="dev-python/pyxdg
	dev-python/pygobject:2
	dev-python/notify-python
	dev-python/pygtk
	dev-python/gst-python
	dev-python/dbus-python
	media-plugins/gst-plugins-meta[aac,http,mp3]
	gnome? ( gnome-base/gnome-settings-daemon )
	!gnome? ( dev-libs/keybinder[python] )"

src_prepare() {
	# replace the build system with something more sane
	epatch "${FILESDIR}"/${PN}-detect-datadir.patch
	cp "${FILESDIR}"/setup.py "${S}"

	distutils-r1_src_prepare
}
