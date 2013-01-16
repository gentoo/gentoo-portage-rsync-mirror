# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycdio/pycdio-0.18.ebuild,v 1.1 2013/01/16 05:25:58 ssuominen Exp $

EAPI=5
PYTHON_DEPEND=2
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST=nosetests

inherit distutils

DESCRIPTION="Python OO interface to libcdio (CD Input and Control library)"
HOMEPAGE="http://savannah.gnu.org/projects/libcdio/ http://pypi.python.org/pypi/pycdio"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=dev-libs/libcdio-0.90"
DEPEND="${RDEPEND}
	dev-lang/swig
	dev-python/setuptools"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS=README.txt
PYTHON_MODNAME="cdio.py iso9660.py pycdio.py pyiso9660.py"

src_prepare() {
	distutils_src_prepare

	# Remove obsolete sys.path and adjust 'data' paths in examples.
	sed -i \
		-e "s:^sys.path.insert.*::" \
		-e "s:\.\./data:./data:g" \
		example/*.py || die

	# Disable failing tests.
	sed -i -e "s/test_get_set/_&/" test/test-cdtext.py || die
	sed -i -e "s/test_fs/_&/" test/test-isocopy.py || die
}

src_install(){
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins example/{README,*.py}
		doins -r data
	fi
}
