# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/pybackpack/pybackpack-0.4.2.ebuild,v 1.3 2011/06/13 14:58:35 pacho Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="GTK+ GUI for the rdiff-backup tool"
HOMEPAGE="http://sucs.org/~davea/trac/wiki"
SRC_URI="http://minus-zero.org/projects/pybackpack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
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
