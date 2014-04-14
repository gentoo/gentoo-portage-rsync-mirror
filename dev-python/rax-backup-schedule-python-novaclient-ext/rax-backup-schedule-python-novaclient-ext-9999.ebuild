# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rax-backup-schedule-python-novaclient-ext/rax-backup-schedule-python-novaclient-ext-9999.ebuild,v 1.3 2014/04/14 19:24:05 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/rackspace/rax_backup_schedule_python_novaclient_ext.git
	https://github.com/rackspace/rax_backup_schedule_python_novaclient_ext.git"

DESCRIPTION="Disk Config extension for python-novaclient"
HOMEPAGE="https://github.com/rackspace/rax_backup_schedule_python_novaclient_ext"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

S="${WORKDIR}/rax_backup_schedule_python_novaclient_ext-${PV}"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/python-novaclient-2.10.0[${PYTHON_USEDEP}]"
