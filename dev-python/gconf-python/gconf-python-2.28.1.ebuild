# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gconf-python/gconf-python-2.28.1.ebuild,v 1.11 2012/02/24 08:48:09 patrick Exp $

EAPI="1"
GCONF_DEBUG="no"
G_PY_PN="gnome-python"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit gnome-python-common

DESCRIPTION="Python bindings for the GConf library"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="examples"

RDEPEND="dev-python/pygobject:2
	>=gnome-base/gconf-2.11.1
	!<dev-python/gnome-python-2.22.1"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gconf/*"
