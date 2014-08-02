# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-evolution/django-evolution-0.7.3.ebuild,v 1.1 2014/08/02 02:02:13 idella4 Exp $

EAPI=5

# This is NOT py3 compatible
PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
RELEASE="0.7"

DESCRIPTION="A Django application that will run cron jobs for other django apps"
HOMEPAGE="http://code.google.com/p/django-evolution/ http://pypi.python.org/pypi/django_evolution/"
SRC_URI="http://downloads.reviewboard.org/releases/${PN}/${RELEASE}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S=${WORKDIR}/${MY_P}
DOCS=( AUTHORS NEWS docs/{evolution.txt,faq.txt} )

python_test() {
	# http://code.google.com/p/django-evolution/issues/detail?id=135
	# This is tested, any delay in die subsequent to (implicitly inherited) multiprocessing eclass
	"${PYTHON}" tests/runtests.py || die
}
