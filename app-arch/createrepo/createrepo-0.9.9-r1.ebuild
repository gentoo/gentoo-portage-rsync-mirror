# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/createrepo/createrepo-0.9.9-r1.ebuild,v 1.1 2014/12/25 00:28:11 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='xml'

inherit python-single-r1 eutils

DESCRIPTION="Creates a common rpm-metadata repository"
HOMEPAGE="http://createrepo.baseurl.org/"
SRC_URI="http://createrepo.baseurl.org/download/${P}.tar.gz
	http://dev.gentoo.org/~pacho/maintainer-needed/${PN}-0.9.9-head.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/urlgrabber-2.9.0[${PYTHON_USEDEP}]
	>=app-arch/rpm-4.1.1[python,${PYTHON_USEDEP}]
	dev-libs/libxml2[python,${PYTHON_USEDEP}]
	>=app-arch/deltarpm-3.6_pre20110223[python,${PYTHON_USEDEP}]
	dev-python/pyliblzma[${PYTHON_USEDEP}]
	>=sys-apps/yum-3.4.3
	${PYTHON_DEPS}"
DEPEND="${PYTHON_DEPS}"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

src_prepare() {
	epatch "${WORKDIR}/${PN}-0.9.9-head.patch"
	epatch "${FILESDIR}/${PN}-0.9.9-ten-changelog-limit.patch"

	sed -i -e '/^sysconfdir/s:=.*/:=/:' Makefile || die
}

src_compile() { :; }

src_install() {
	emake install DESTDIR="${D}"
	dodoc ChangeLog README
	python_fix_shebang "${ED}"
}
