# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bleachbit/bleachbit-0.9.5.ebuild,v 1.3 2013/04/10 08:43:19 pinkbyte Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 eutils

DESCRIPTION="Clean junk to free disk space and to maintain privacy"
HOMEPAGE="http://bleachbit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="dev-python/pygtk:2[$PYTHON_USEDEP]"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

DOCS=( README )

src_prepare() {
	addpredict /root/.gnome2 #401981

	# warning: key "Encoding" in group "Desktop Entry" is deprecated
	sed -i -e '/Encoding/d' ${PN}.desktop || die

	# choose correct Python implementation, bug #465254
	python_export_best
	sed -i -e 's/python/$(PYTHON)/g' po/Makefile || die

	distutils-r1_src_prepare
}

src_compile() {
	distutils-r1_src_compile
	use nls && emake -C po
}

src_install() {
	distutils-r1_src_install
	use nls && emake -C po DESTDIR="${D}" install

	# http://bugs.gentoo.org/388999
	insinto /usr/share/${PN}/cleaners
	doins cleaners/*.xml

	newbin ${PN}.py ${PN}
	python_replicate_script "${D}/usr/bin/${PN}"

	doicon ${PN}.png
	domenu ${PN}.desktop
}
