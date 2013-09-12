# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horizon/horizon-2013.1.9999.ebuild,v 1.5 2013/09/12 06:23:06 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="Horizon is a Django-based project aimed at providing a complete
OpenStack Dashboard."
HOMEPAGE="https://launchpad.net/horizon"
EGIT_REPO_URI="https://github.com/openstack/horizon.git"
EGIT_BRANCH="stable/grizzly"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/django-1.4[${PYTHON_USEDEP}]
		<dev-python/django-1.5[${PYTHON_USEDEP}]
		dev-python/django-compressor[${PYTHON_USEDEP}]
		>=dev-python/django-openstack-auth-1.0.7[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.2[${PYTHON_USEDEP}]
		<dev-python/python-cinderclient-2.0.0[${PYTHON_USEDEP}]
		<dev-python/python-glanceclient-2[${PYTHON_USEDEP}]
		dev-python/python-keystoneclient[${PYTHON_USEDEP}]
		>=dev-python/python-novaclient-2.12.0[${PYTHON_USEDEP}]
		<dev-python/python-novaclient-3[${PYTHON_USEDEP}]
		>=dev-python/python-quantumclient-2.2.0[${PYTHON_USEDEP}]
		<dev-python/python-quantumclient-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-swiftclient-1.1[${PYTHON_USEDEP}]
		<dev-python/python-swiftclient-2[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/lockfile[${PYTHON_USEDEP}]"
