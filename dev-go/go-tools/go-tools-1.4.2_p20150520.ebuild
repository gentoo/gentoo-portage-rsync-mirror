# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-go/go-tools/go-tools-1.4.2_p20150520.ebuild,v 1.2 2015/05/21 08:28:23 zmedico Exp $

EAPI=5

KEYWORDS="~amd64"
DESCRIPTION="Go Tools"
MY_PN=${PN##*-}
GO_PN=golang.org/x/${MY_PN}
HOMEPAGE="https://godoc.org/${GO_PN}"
EGIT_COMMIT="3d1847243ea4f07666a91110f48e79e43396603d"
SRC_URI="https://github.com/golang/${MY_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/go-1.4
	dev-go/go-net"
RDEPEND=""
S="${WORKDIR}/src/${GO_PN}"
EGIT_CHECKOUT_DIR="${S}"
STRIP_MASK="*.a"

src_unpack() {
	default
	mkdir -p src/${GO_PN%/*} || die
	mv ${MY_PN}-${EGIT_COMMIT} src/${GO_PN} || die
}

src_compile() {
	# Create a writable GOROOT in order to avoid sandbox violations.
	GOROOT="${WORKDIR}/goroot"
	cp -sR "${EPREFIX}"/usr/lib/go "${GOROOT}" || die
	rm -rf "${GOROOT}/src/${GO_PN}" \
		"${GOROOT}/pkg/linux_${ARCH}/${GO_PN}" || die
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} go install -v -x -work ${GO_PN}/... || die
}

src_test() {
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} \
		go test -run "^"$(
		echo -n 'Test(ParseLine|ParseSet|SelectBest|Delta|Correlate|'
		echo -n 'BenchCmpSorting|Callgraph-4|Cover|Digraph|Split|'
		echo -n 'QuotedLength|FixImports|DryRun)$') \
		-x -v ${GO_PN}/... || die $?
}

src_install() {
	exeinto /usr/lib/go/bin
	doexe "${WORKDIR}"/bin/*
	insinto /usr/lib/go
	find "${WORKDIR}"/{pkg,src} -name '.git*' -exec rm -rf {} \; 2>/dev/null
	doins -r "${WORKDIR}"/{pkg,src}
	exeinto /usr/lib/go/pkg/tool/linux_amd64
	find "${GOROOT}/pkg/tool/linux_amd64" -type f -exec doexe {} \;
}
