# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/logging/logging-1.8.1-r1.ebuild,v 1.1 2013/12/19 23:33:45 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC="doc"
RAKE_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Flexible logging library for use in Ruby programs based on the design of Java's log4j library"
HOMEPAGE="http://rubygems.org/gems/logging"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_rdepend ">=dev-ruby/little-plugger-1.1.3 >=dev-ruby/multi_json-1.3.6"

ruby_add_bdepend "dev-ruby/bones test? ( dev-ruby/flexmock )"
