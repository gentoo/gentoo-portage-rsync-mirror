# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rhpl/rhpl-0.219.ebuild,v 1.3 2012/02/21 08:59:00 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit multilib python rpm toolchain-funcs

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="2"

DESCRIPTION="Library of python code used by Red Hat Linux programs"
HOMEPAGE="http://fedoraproject.org/wiki/SystemConfig"
SRC_URI="mirror://fedora-dev/development/source/SRPMS/${P}-${RPMREV}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="!<sys-libs/libkudzu-1.2"
DEPEND="${RDEPEND}
	!s390? ( >=net-wireless/wireless-tools-28 )
	sys-devel/gettext"

src_prepare() {
	sed -e '/compileall/d' -i Makefile || die "sed failed"
	sed \
		-e 's:CFLAGS=:CFLAGS+=:' \
		-e 's:gcc:$(CC):g' \
		-e 's:-shared:& $(LDFLAGS):' \
		-i src/Makefile || die "sed failed"
	python_src_prepare
}

src_compile() {
	building() {
		emake \
			PYTHON=$(PYTHON) \
			LIBDIR=$(get_libdir) \
			ARCH=${ARCH} \
			CC=$(tc-getCC)
	}
	python_execute_function -s building
}

src_install() {
	installation() {
		emake \
			DESTDIR="${ED}" \
			PYTHON=$(PYTHON) \
			LIBDIR=$(get_libdir) \
			install
	}
	python_execute_function -s installation
}

pkg_postinst() {
	python_mod_optimize rhpl
}

pkg_postrm() {
	python_mod_cleanup rhpl
}
