# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nautilus-python/nautilus-python-1.1-r2.ebuild,v 1.2 2014/12/25 00:08:43 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 python-single-r1

DESCRIPTION="Python bindings for the Nautilus file manager"
HOMEPAGE="http://projects.gnome.org/nautilus-python/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE="doc"

# Depend on pygobject:3 for sanity, and because it's automagic
RDEPEND="dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=gnome-base/nautilus-2.32[introspection]
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.9 )"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

DOCS="AUTHORS ChangeLog NEWS README"

src_install() {
	gnome2_src_install
	# Directory for systemwide extensions
	keepdir /usr/share/nautilus-python/extensions
	# Doesn't get installed by "make install" for some reason
	if use doc; then
		insinto /usr/share/gtk-doc/html/nautilus-python # for dev-util/devhelp
		doins -r docs/html/.
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst
}
