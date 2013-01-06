# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/pybackpack/pybackpack-0.5.8.ebuild,v 1.1 2011/08/31 06:54:35 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="GTK+ GUI for the rdiff-backup tool"
HOMEPAGE="http://sucs.org/~davea/trac/wiki"
SRC_URI="http://minus-zero.org/projects/pybackpack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-backup/rdiff-backup-0.12.7
	dev-python/libgnome-python
	dev-python/gnome-vfs-python
	dev-python/pygobject:2
	dev-python/pygtk:2"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
