# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-openstack-auth/django-openstack-auth-1.0.7.ebuild,v 1.1 2013/04/12 01:37:51 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A Django authentication backend for use with the OpenStack Keystone
Identity backend."
HOMEPAGE="http://django_openstack_auth.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/django_openstack_auth/django_openstack_auth-${PV}.tar.gz"
S="${WORKDIR}/django_openstack_auth-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/mox[${PYTHON_USEDEP}] )"
RDEPEND=">=dev-python/python-keystoneclient-0.2[${PYTHON_USEDEP}]
		>=dev-python/django-1.4[${PYTHON_USEDEP}]"
