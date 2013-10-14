# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevdev/libevdev-0.4.ebuild,v 1.2 2013/10/14 14:39:04 chithanh Exp $

EAPI=5
XORG_MULTILIB=yes
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit python-single-r1 xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}.git"

DESCRIPTION="Handler library for evdev events"

if [[ ${PV} == 9999* ]] ; then
	SRC_URI=""
else
	SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.xz"
fi

KEYWORDS="~amd64 ~ppc"
IUSE=""

src_prepare() {
	python_fix_shebang libevdev/make-event-names.py
	xorg-2_src_prepare
}
