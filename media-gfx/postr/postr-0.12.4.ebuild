# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/postr/postr-0.12.4.ebuild,v 1.3 2012/10/09 22:53:51 tetromino Exp $

EAPI="4"

GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"

PYTHON_COMPAT="python2_6 python2_7"

inherit gnome2 python-distutils-ng

DESCRIPTION="Flickr uploader for GNOME"
HOMEPAGE="http://projects.gnome.org/postr/"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/bsddb3
	dev-python/gconf-python
	dev-python/pygobject:2
	dev-python/pygtk:2
	dev-python/twisted
	dev-python/twisted-web"
DEPEND=""

python_prepare_all() {
	# FIXME: nautilus extension is nautilus-2-only; is it worth enabling for
	# legacy users?
	sed -e '/nautilus\/extensions/ d' -i setup.py || die
}
