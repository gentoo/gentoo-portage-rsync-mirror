# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uuidtools/uuidtools-2.1.5.ebuild,v 1.1 2014/08/14 14:11:15 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC="-f tasks/yard.rake doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"

inherit ruby-fakegem

DESCRIPTION="Simple library to generate UUIDs"
HOMEPAGE="http://uuidtools.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE="doc"

ruby_add_bdepend "doc? ( dev-ruby/yard )"
