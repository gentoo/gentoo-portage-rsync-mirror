# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yum/yum-3.4.3-r1.ebuild,v 1.1 2013/05/04 20:21:32 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

inherit eutils multilib python-single-r1

DESCRIPTION="automatic updater and package installer/remover for rpm systems"
HOMEPAGE="http://yum.baseurl.org/"
SRC_URI="http://yum.baseurl.org//download/${PV:0:3}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="${PYTHON_DEPS}
	app-arch/rpm[${PYTHON_USEDEP}]
	dev-python/sqlitecachec[${PYTHON_USEDEP}]
	dev-libs/libxml2[python,${PYTHON_USEDEP}]
	dev-python/urlgrabber[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-util/intltool
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

src_prepare() {
	sed -i -e 's/make/$(MAKE)/' Makefile || die
	sed -i -e "s:lib:$(get_libdir):g" rpmUtils/Makefile yum/Makefile || die
}

src_install() {
	emake DESTDIR="${ED}" install
	python_optimize "${D%/}$(python_get_sitedir)" "${ED%/}/usr/share/yum-cli"
	rm -r "${ED%/}/etc/rc.d" || die
}
