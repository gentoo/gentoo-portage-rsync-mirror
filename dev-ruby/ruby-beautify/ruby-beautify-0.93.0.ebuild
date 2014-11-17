# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-beautify/ruby-beautify-0.93.0.ebuild,v 1.1 2014/11/17 06:41:09 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md RELEASE.md"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="a cli tool (and module) to beautify ruby code"
HOMEPAGE="https://github.com/erniebrodeur/ruby-beautify"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""
