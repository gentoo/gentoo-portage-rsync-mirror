# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/pythia/pythia-8.1.70.ebuild,v 1.2 2012/11/30 22:08:58 bicatali Exp $

EAPI=4

inherit eutils fortran-2 versionator

MV=$(get_major_version)
MY_P=${PN}$(replace_all_version_separators "" ${PV})

DESCRIPTION="Lund Monte Carlo high-energy physics event generator"
HOMEPAGE="http://pythia8.hepforge.org/"
SRC_URI="http://home.thep.lu.se/~torbjorn/${PN}${MV}/${MY_P}.tgz"

SLOT="8"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples +hepmc static-libs"

DEPEND="hepmc? ( sci-physics/hepmc )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	use hepmc && export HEPMCVERSION=2 HEPMCLOCATION="${EPREFIX}/usr"
	# homemade configure script creates a useless config.mk
	rm -f config.mk
	cat > config.mk <<-EOF
		SHAREDLIBS = yes
		LDFLAGSSHARED = -shared ${LDFLAGS}
		LDFLAGLIBNAME = -Wl,-soname
		SHAREDSUFFIX = so
	EOF
	if ! use static-libs; then
		sed -i \
			-e '/targets.*\.a/d' \
			-e 's/+=\(.*libpythia8\)/=\1/' \
			Makefile || die
		sed -i \
			-e 's:\.a:\.so:g' \
			-e 's:$(LIBDIRARCH):$(LIBDIR):g' \
			examples/Makefile || die
	fi
}

src_test() {
	cd examples
	# use emake for parallel instead of long runmains
	emake main0{1..9}
	for i in main0{1..9}*.exe; do
		LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}" \
			./${i} > ${i}.out || die "test ${i} failed"
	done
	if use hepmc; then
		emake main31
		LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}" \
			./main31.exe > main31.exe.out || die
	fi
	emake clean && rm -f main*out
}

src_install() {
	dolib.so lib/*so
	use static-libs && dolib.a lib/archive/*

	insinto /usr/include/${PN}
	doins include/*

	# xmldoc needed by root
	insinto /usr/share/${PN}
	doins -r xmldoc

	echo "PYTHIA8DATA=${EROOT}usr/share/${PN}/xmldoc" >> 99pythia8
	doenvd 99pythia8

	dodoc GUIDELINES AUTHORS README
	if use doc; then
		dodoc worksheet.pdf
		dohtml -r htmldoc/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
