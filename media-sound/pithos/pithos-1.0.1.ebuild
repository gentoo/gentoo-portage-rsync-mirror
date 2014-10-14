# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pithos/pithos-1.0.1.ebuild,v 1.1 2014/10/14 20:16:30 chutzpah Exp $

EAPI=5
PYTHON_COMPAT=(python3_3)
inherit eutils distutils-r1

if [[ ${PV} =~ [9]{4,} ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/pithos/pithos.git
		https://github.com/pithos/pithos.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Pandora.com client for the GNOME desktop"
HOMEPAGE="http://pithos.github.io/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libnotify appindicator +keybinder"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pylast[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	>=dev-python/pygobject-3.12[${PYTHON_USEDEP}]
	media-plugins/gst-plugins-meta:1.0[aac,http,mp3]
	>=x11-libs/gtk+-3.12:3[introspection]
	libnotify? ( x11-libs/libnotify[introspection] )
	appindicator? ( dev-libs/libappindicator:3[introspection] )
	keybinder? ( dev-libs/keybinder:3[introspection] )"

PATCHES=("${FILESDIR}/${PN}-1.0.0-icons.patch")

python_test() {
	esetup.py test || die
}
