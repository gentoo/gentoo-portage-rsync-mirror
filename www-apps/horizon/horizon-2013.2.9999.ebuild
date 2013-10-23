# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horizon/horizon-2013.2.9999.ebuild,v 1.1 2013/10/23 06:19:19 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="Horizon is a Django-based project aimed at providing a complete
OpenStack Dashboard."
HOMEPAGE="https://launchpad.net/horizon"
EGIT_REPO_URI="https://github.com/openstack/horizon.git"
EGIT_BRANCH="stable/havana"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/django-1.4[${PYTHON_USEDEP}]
		<dev-python/django-1.6[${PYTHON_USEDEP}]
		>=dev-python/django-compressor-1.3[${PYTHON_USEDEP}]
		>=dev-python/django-openstack-auth-1.1.1[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
		>=dev-python/kombu-2.4.8[${PYTHON_USEDEP}]
		>=dev-python/lesscpy-0.9j[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.5[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/python-heatclient-0.2.3[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/python-novaclient-2.15.0[${PYTHON_USEDEP}]
		>=dev-python/python-neutronclient-2.3.0[${PYTHON_USEDEP}]
		<dev-python/python-neutronclient-3[${PYTHON_USEDEP}]
		>=dev-python/python-swiftclient-1.5[${PYTHON_USEDEP}]
		>=dev-python/python-ceilometerclient-1.0.5[${PYTHON_USEDEP}]
		<dev-python/python-troveclient-1[${PYTHON_USEDEP}]
		>=dev-python/pytz-2010h[${PYTHON_USEDEP}]
		>=dev-python/lockfile-0.8[${PYTHON_USEDEP}]"
