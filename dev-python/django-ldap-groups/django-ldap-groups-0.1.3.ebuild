# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-ldap-groups/django-ldap-groups-0.1.3.ebuild,v 1.1 2012/04/25 16:43:46 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A reusable application for the Django web framework"
HOMEPAGE="http://code.google.com/p/django-ldap-groups"
SRC_URI="http://django-ldap-groups.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="ldap_groups"
DOCS=( ldap_groups/README )

RDEPEND=""
DEPEND="${RDEPEND} dev-python/django
	dev-python/setuptools"
