# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docutils/docutils-0.9.1.ebuild,v 1.12 2013/01/04 21:56:30 ago Exp $

EAPI="4"
PYTHON_DEPEND="*::3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.3"

inherit distutils

DESCRIPTION="Docutils - Python Documentation Utilities"
HOMEPAGE="http://docutils.sourceforge.net/ http://pypi.python.org/pypi/docutils"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SRC_URI+=" glep? ( mirror://gentoo/glep-0.4-r1.tbz2 )"

LICENSE="BSD-2 GPL-3 public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="glep"

RDEPEND="dev-python/pygments"
DEPEND="${RDEPEND}"

DOCS="*.txt"

GLEP_SRC="${WORKDIR}/glep-0.4-r1"

src_compile() {
	distutils_src_compile

	# Generate html docs from reStructured text sources.

	# Place html4css1.css in base directory to ensure that the generated reference to it is correct.
	cp docutils/writers/html4css1/html4css1.css .

	pushd tools > /dev/null

	PYTHONPATH="../build-$(PYTHON -f --ABI)/lib" "$(PYTHON -f)" \
		../tools/buildhtml.py --input-encoding=utf-8 \
		--stylesheet-path=../html4css1.css --traceback ../docs || die

	popd > /dev/null

	# Clean up after building of documentation.
	rm html4css1.css
}

src_test() {
	testing() {
		local testfile=test/alltests.py
		if [[ $(python_get_version --language --major) == 3 ]]; then
			testfile=test3/alltests.py
		fi
		echo PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" "${testfile}"
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" "${testfile}"
	}
	python_execute_function testing
}

install_txt_doc() {
	local doc="${1}"
	local dir="txt/$(dirname ${doc})"
	docinto "${dir}"
	dodoc "${doc}"
}

src_install() {
	distutils_src_install

	postinstallational_preparation() {
		# Install tools.
		mkdir -p "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
		cp tools/{buildhtml,quicktest}.py \
			"${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
	}
	python_execute_function -q postinstallational_preparation
	python_merge_intermediate_installation_images "${T}/images"

	# Install documentation.
	dohtml -r docs tools

	# Install stylesheet file.
	insinto /usr/share/doc/${PF}/html
	doins docutils/writers/html4css1/html4css1.css
	local doc
	for doc in $(find docs tools -name "*.txt"); do
		install_txt_doc "${doc}"
	done

	# Install Gentoo GLEP tools.
	if use glep; then
		dobin "${GLEP_SRC}/glep.py"

		installation_of_glep_tools() {
			insinto $(python_get_sitedir)/docutils/readers
			newins "${GLEP_SRC}/glepread.py" glep.py
			insinto $(python_get_sitedir)/docutils/transforms
			newins "${GLEP_SRC}/glepstrans.py" gleps.py
			insinto $(python_get_sitedir)/docutils/writers
			doins -r "${GLEP_SRC}/glep_html"
		}
		python_execute_function --action-message 'Installation of GLEP tools with $(python_get_implementation_and_version)' installation_of_glep_tools
	fi
}

pkg_preinst() {
	# Remove egg-info directory left over from setuptools.
	[[ ${PV} == 0.9.1 ]] || die "pkg_preinst no longer needed"
	remove_egg_info() {
		local lv="$(python_get_version --language)"
		local sitedir="$(python_get_sitedir --base-path)"
		local egg_info="${ROOT}${sitedir}/${P}-py${lv}.egg-info"
		if [[ -d "${egg_info}" ]]; then
			rm -r "${egg_info}"
		fi
	}
	python_execute_function -q remove_egg_info
}
