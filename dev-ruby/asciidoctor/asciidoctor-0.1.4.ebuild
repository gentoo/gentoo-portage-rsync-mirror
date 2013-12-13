# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/asciidoctor/asciidoctor-0.1.4.ebuild,v 1.1 2013/12/13 04:10:45 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_TEST="rake"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.adoc"

inherit ruby-fakegem

DESCRIPTION="Processor for converting AsciiDoc source files or strings into HTML 5, DocBook 4.5 and other formats"
HOMEPAGE="https://github.com/asciidoctor/asciidoctor"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? (
	dev-ruby/coderay
	dev-ruby/erubis
	dev-ruby/haml
	dev-ruby/nokogiri
	dev-ruby/slim
	dev-ruby/tilt )"
