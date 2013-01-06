# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtinst/virtinst-0.600.0.ebuild,v 1.4 2012/01/28 15:25:29 phajdan.jr Exp $

#BACKPORTS=1

EAPI=3

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="http://git.fedorahosted.org/git/python-virtinst.git"
	GIT_ECLASS="git-2"
fi

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils ${GIT_ECLASS}

if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://virt-manager.et.redhat.com/download/sources/${PN}/${P}.tar.gz
		${BACKPORTS:+mirror://gentoo/${P}-backports-${BACKPORTS}.tar.bz2}"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="Python modules for starting virtualized guest installations"
HOMEPAGE="http://virt-manager.et.redhat.com/"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND=">=app-emulation/libvirt-0.7.0[python]
	dev-python/urlgrabber
	dev-libs/libxml2[python]"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="virtconv virtinst"

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
		epatch

	distutils_src_prepare
}
